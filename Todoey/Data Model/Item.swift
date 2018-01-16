//
//  Item.swift
//  Todoey
//
//  Created by Oky Nugroho Kusumo on 16/01/2018.
//  Copyright © 2018 Oky Nugroho Kusumo. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
