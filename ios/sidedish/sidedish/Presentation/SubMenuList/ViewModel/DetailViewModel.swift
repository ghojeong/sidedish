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
                
            }.store(in: &self.cancelBag)
        }
    }
}
