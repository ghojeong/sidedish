//
//  DetailViewModel.swift
//  sidedish
//
//  Created by 박정하 on 2021/04/28.
//

import Foundation
import Combine

class DetailViewModel {
    @Published var sideDishDetail : SideDishManageable!
    
    private var tapMainmenuCellUsecase : TapMainmenuCellUsecase!
    private var cancelBag = Set<AnyCancellable>()
    
    init(TapMainmenuCellUsecase: TapMainmenuCellUsecase) {
        self.tapMainmenuCellUsecase = TapMainmenuCellUsecase
    }
    
    convenience init() {
        let tapmainmenuCellUsecase = TapMainmenuCellUsecase()
        self.init(TapMainmenuCellUsecase: tapmainmenuCellUsecase)
    }
    
    func configureDetailMenuBoard(section: Int, row: Int, completion: @escaping () -> Void){
        tapMainmenuCellUsecase.manufactureToTapUsecase(section: section, row: row, endPoint: EndPoint.sideDishes[section]) { (publisher) in
            publisher
                .receive(on: DispatchQueue.main)
                .sink { (_) in
            } receiveValue: { result in
                self.sideDishDetail = result
                self.quantityToaster(for: self.sideDishDetail.getID(), completionHandler: CustomToaster.popStockBubble(count:))
            }.store(in: &self.cancelBag)
        }
    }
    
    private func quantityToaster(for hash: String, completionHandler: @escaping (Int) -> ()) {
        let quantity = NetworkManager(with: "http://3.37.26.82:8080")
            .get(decodingType: [String: Int].self, endPoint: "/detail/\(hash)/quantity")
        quantity.sink { _ in
        } receiveValue: { quantity in
            let count = quantity["quantity"] ?? 0
            completionHandler(count)
        }.store(in: &self.cancelBag)
    }
}
