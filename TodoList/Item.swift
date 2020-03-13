//
//  Item.swift
//  TodoList
//
//  Created by Talha on 12/03/2020.
//  Copyright © 2020 Talha. All rights reserved.
import Foundation
import RealmSwift
class Item : Object {
   @objc dynamic var title : String = ""
   @objc dynamic var done : Bool =  false
    @objc dynamic var dateCreated : Date?
    // For Parent relation ship
    var parentCategory = LinkingObjects(fromType: Categories.self, property: "items")
}
