//
//  Item+CoreDataProperties.swift
//  WishList
//
//  Created by Khoa on 2/1/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var price: Float
    @NSManaged public var title: String?
    @NSManaged public var toImage: Image?
    @NSManaged public var toStore: Store?

}
