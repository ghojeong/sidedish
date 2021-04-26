//
//  TurnonAppUsecase.swift
//  sidedish
//
//  Created by 박정하 on 2021/04/21.
//

import Foundation
import Combine
import Alamofire

protocol ManufactureDataforViewModel {
    
    func manufactureForMainViewCategory() -> AnyPublisher<[SideDishesCategory], AFError>
    
    func manufactureForMainViewSideDishes(endPoint: String) -> AnyPublisher<[SideDish], AFError>
    
}

class TurnonAppUsecase: ManufactureDataforViewModel {

    private let networkmanager: AFNetworkManagable
    
    init(networkmanager: AFNetworkManagable) {
        self.networkmanager = networkmanager
    }
    
    convenience init(baseUrl: String = "http://3.37.26.82:8080"){
        let networkmanager = NetworkManager(baseAddress: baseUrl)
        self.init(networkmanager : networkmanager)
    }
    
    func manufactureForMainViewCategory() -> AnyPublisher<[SideDishesCategory], AFError> {
        return networkmanager.get(decodingType: [SideDishesCategory].self, endPoint: EndPoint.categories)
    }
    
    func manufactureForMainViewSideDishes(endPoint: String) -> AnyPublisher<[SideDish], AFError> {
        return networkmanager.get(decodingType: [SideDish].self, endPoint: endPoint)
    }
}