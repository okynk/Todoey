//
//  Category.swift
//  Todoey
//
//  Created by Oky Nugroho Kusumo on 16/01/2018.
//  Copyright © 2018 Oky Nugroho Kusumo. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
