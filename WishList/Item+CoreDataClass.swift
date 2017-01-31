//
//  Item+CoreDataClass.swift
//  WishList
//
//  Created by Khoa on 1/31/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {

    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.created = NSDate()
    }
}
