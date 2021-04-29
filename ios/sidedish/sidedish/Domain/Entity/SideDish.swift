//
//  SideDish.swift
//  sidedish
//
//  Created by Song on 2021/04/20.
//

import Foundation
import CoreData

protocol SideDishManageable {
    func getTitle() -> String
    func getImageURL() -> String
    func getdescription() -> String
    func getPrice() -> Int
    func getSalePrice() -> Int
    func getDeliveryTypes() -> [String]?
    func getbadge() -> [String]?
    func getID() -> String
    func updateThumbnailPath(_ path: String)
    func getDetail() -> SideDishDetail?
    func getThumbnailPath() -> String?
}

public class SideDish: NSObject, NSCoding, Codable, SideDishManageable {

    
    
    public required init?(coder: NSCoder) {
        self.id = coder.decodeObject(of: NSString.self, forKey: CodingKeys.id.rawValue) as String? ?? ""
        self.image = coder.decodeObject(of: NSString.self, forKey: CodingKeys.image.rawValue) as String? ?? ""
        self.title = coder.decodeObject(of: NSString.self, forKey: CodingKeys.title.rawValue) as String? ?? ""
        self.subtitle = coder.decodeObject(of: NSString.self, forKey: CodingKeys.subtitle.rawValue) as String? ?? ""
        self.price = coder.decodeInteger(forKey: CodingKeys.price.rawValue)
        self.salePrice = coder.decodeInteger(forKey: CodingKeys.salePrice.rawValue)
        self.deliveryTypes = coder.decodeObject(of: [NSString.self], forKey: CodingKeys.deliveryTypes.rawValue) as? [String]
        self.badges = coder.decodeObject(of: [NSString.self], forKey: CodingKeys.badges.rawValue) as? [String]
        self.thumbnailPath = coder.decodeObject(of: NSString.self, forKey: CodingKeys.thumbnailPath.rawValue) as String? ?? ""
        self.detail = coder.decodeObject(of: SideDishDetail.self, forKey: CodingKeys.detail.rawValue)
    }
    
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: CodingKeys.id.rawValue)
        coder.encode(image, forKey: CodingKeys.image.rawValue)
        coder.encode(title, forKey: CodingKeys.title.rawValue)
        coder.encode(subtitle, forKey: CodingKeys.subtitle.rawValue)
        coder.encode(price, forKey: CodingKeys.price.rawValue)
        coder.encode(salePrice, forKey: CodingKeys.salePrice.rawValue)
        coder.encode(deliveryTypes, forKey: CodingKeys.deliveryTypes.rawValue)
        coder.encode(badges, forKey: CodingKeys.badges.rawValue)
        coder.encode(thumbnailPath, forKey: CodingKeys.thumbnailPath.rawValue)
        coder.encode(detail, forKey: CodingKeys.detail.rawValue)
    }
    
    
    func getTitle() -> String {
        self.title
    }
    
    func getImageURL() -> String {
        self.image
    }
    
    func getdescription() -> String {
        self.subtitle
    }
    
    func getPrice() -> Int {
        self.price
    }
    
    func getSalePrice() -> Int {
        self.salePrice
    }
    
    func getDeliveryTypes() -> [String]? {
        self.deliveryTypes
    }
    
    func getbadge() -> [String]? {
        self.badges
    }
    
    func getID() -> String {
        self.id
    }
    
    func updateThumbnailPath(_ path: String) {
        self.thumbnailPath = path
    }
    
    func getThumbnailPath() -> String? {
        self.thumbnailPath
    }
    
    func getDetail() -> SideDishDetail? {
        self.detail
    }

    let id: String
    let image: String //library/cache의 파일명
    let title: String //"[소중한식사] 골뱅이무침 195g"
    let subtitle: String //"매콤새콤달콤, 반찬으로도 안주로도 좋은"
    let price: Int //7,000
    let salePrice: Int //6,300
    let deliveryTypes: [String]? //["새벽배송","전국택배"]
    let badges: [String]? //["이벤트특가", "런칭특가"]
    var thumbnailPath: String?
    var detail: SideDishDetail?
    
    enum CodingKeys: String, CodingKey {
        case id = "detailHash"
        case image
        case title
        case subtitle = "description"
        case price
        case salePrice
        case deliveryTypes
        case badges
        case thumbnailPath
        case detail
    }
}

public class SideDishDetail: NSObject, NSCoding, Codable {
    public func encode(with coder: NSCoder) {
        coder.encode(thumbImages, forKey: CodingKeys.thumbImages.rawValue)
        coder.encode(point, forKey: CodingKeys.point.rawValue)
        coder.encode(deliveryInfo, forKey: CodingKeys.deliveryInfo.rawValue)
        coder.encode(deliveryFee, forKey: CodingKeys.deliveryFee.rawValue)
        coder.encode(detailImages, forKey: CodingKeys.detailImages.rawValue)
    }
    
    public required init?(coder: NSCoder) {
        self.thumbImages = coder.decodeObject(of: [NSString.self], forKey: CodingKeys.thumbImages.rawValue) as? [String] ?? []
        self.point = coder.decodeInteger(forKey: CodingKeys.point.rawValue)
        self.deliveryInfo = coder.decodeObject(of: NSString.self, forKey: CodingKeys.deliveryInfo.rawValue) as String? ?? ""
        self.deliveryFee = coder.decodeInteger(forKey: CodingKeys.deliveryFee.rawValue)
        self.detailImages = coder.decodeObject(of: [NSString.self], forKey: CodingKeys.detailImages.rawValue) as? [String] ?? []
    }
    
    var thumbImages: [String]
    let point: Int
    let deliveryInfo: String
    let deliveryFee: Int
    let detailImages: [String]
    
    enum CodingKeys: String, CodingKey {
        case thumbImages
        case point
        case deliveryInfo
        case deliveryFee
        case detailImages
    }
}
