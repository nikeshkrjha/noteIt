//
//  Category.swift
//  NoteIt
//
//  Created by Nikesh Jha on 2/1/19.
//  Copyright © 2019 Nikesh Jha. All rights reserved.
//

import UIKit
import RealmSwift

class Category: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var category_name: String = ""
    @objc dynamic var created_by: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
