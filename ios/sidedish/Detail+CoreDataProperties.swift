//
//  Detail+CoreDataProperties.swift
//  sidedish
//
//  Created by 박정하 on 2021/04/28.
//
//

import Foundation
import CoreData


extension SaveDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaveDetail> {
        return NSFetchRequest<SaveDetail>(entityName: "Detail")
    }

    @NSManaged public var deliveryInfo: String?
    @NSManaged public var detailImages: [String]?
    @NSManaged public var deliveryFee: Int16
    @NSManaged public var point: Int16
    @NSManaged public var index: Int16
    @NSManaged public var thumbImages: [String]
    @NSManaged public var sideDishDetail: [SaveDetail]

    enum Properties {
        static let entity = "Detail"
        static let detailImages = "detailImages"
        static let deliveryFee = "deliveryFee"
        static let point = "point"
        static let thumbImages = "thumbImages"
        static let deliveryInfo = "deliveryInfo"
        
    }
}

extension SaveDetail : Identifiable {

}
