//
//  SideDish.swift
//  sidedish
//
//  Created by Song on 2021/04/20.
//

import Foundation

class SideDish: Codable {
    var detail_hash : String
    var image : String //library/cache의 파일명
    var alt : String
    var title: String //"[소중한식사] 골뱅이무침 195g"
    var description: String //"매콤새콤달콤, 반찬으로도 안주로도 좋은"
    var n_price: String? //7,000
    var s_price: String? //6,300
    var delivery_type : [String]? //["새벽배송","전국택배"]
    var badge : [String]? //["이벤트특가", "런칭특가"]
}

class Detail: Codable {
    var thumbImages: [String] //library/cache의 파일명들
    var point: String //"63원"
    var deliveryInfo: String //"서울 경기 새벽배송 / 전국택배 (제주 및 도서산간 불가) [화 수 목 금 토] 수령 가능한 상품입니다"
    var deliveryFee: String //"2,500원 (40,000원 이상 구매 시 무료)"
    var detailImages: [String]
}