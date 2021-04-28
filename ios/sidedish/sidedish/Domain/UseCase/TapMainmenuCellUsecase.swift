//
//  TapMainmenuCellUsecase.swift
//  sidedish
//
//  Created by 박정하 on 2021/04/28.
//

import Foundation

class TapMainmenuCellUsecase {
    private let repository : DishRepository
    
    init(repository: DishRepository) {
        self.repository = repository
        self.repository.deleteAllInCoreData()
    }
    
    func manufactureforDetailView() {
        //requestToRepository
    }
}
