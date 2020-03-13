//
//  Categories.swift
//  TodoList
//
//  Created by Talha on 12/03/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import Foundation
import RealmSwift
class Categories : Object {
    @objc dynamic var name : String = ""
    // For creating a Realtion Ship
    let items = List<Item>()
   
}
