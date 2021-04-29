//
//  TapMainmenuCellUsecase.swift
//  sidedish
//
//  Created by 박정하 on 2021/04/28.
//

import Foundation
import Combine

class TapMainmenuCellUsecase {
    private let repository : DishRepository
    
    init(repository: DishRepository) {
        self.repository = repository
    }
    
    convenience init(baseUrl: String = "http://3.37.26.82:8080"){
        let repository = DishRepository(with: baseUrl)
        self.init(repository: repository)
    }
    
    func manufactureToTapUsecase(section: Int, row: Int, endPoint: String, completionHandler: @escaping (Just<SideDishManageable>) ->()) {
        return repository.getSideDishDetail(endPoint: endPoint, section: section, row: row) { (publiser) in
            completionHandler(publiser)
        }
    }
    
}
