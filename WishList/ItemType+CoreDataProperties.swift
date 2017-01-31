//
//  ItemType+CoreDataProperties.swift
//  WishList
//
//  Created by Khoa on 1/31/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
