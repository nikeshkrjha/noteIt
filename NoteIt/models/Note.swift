//
//  Note.swift
//  NoteIt
//
//  Created by Nikesh Jha on 1/31/19.
//  Copyright © 2019 Nikesh Jha. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import RealmSwift

class Note: Object {
    @objc dynamic var todo_title: String? = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var todo_desc: String? = ""
    @objc dynamic var todo_status = false
    @objc dynamic var created_date: String? = ""
    @objc dynamic var updated_date: String? = ""
    @objc dynamic var created_by: Int = 0
    @objc dynamic var category: Int = 0
    @objc dynamic var uuid = UUID().uuidString
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
