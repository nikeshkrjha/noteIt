//
//  DatabaseManager.swift
//  NoteIt
//
//  Created by Nikesh Jha on 1/31/19.
//  Copyright © 2019 Nikesh Jha. All rights reserved.
//

import Foundation
import RealmSwift


class DatabaseManager {
    var realm: Realm?
    static let shareInstance: DatabaseManager = DatabaseManager()
    
    private init(){
        realm = try! Realm()
    }
    
    func getRealmPath() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    func saveSyncedResponse(dataDict: [String: Any]){
        print(getRealmPath())
        realm = try! Realm()
        try! realm?.write {
            for (key, value) in dataDict{
                let objects = value as! [AnyObject]
                let realmObjects = objects.map { Note(value: $0)}
                realm?.add(realmObjects, update: true)
            }
        }
    }
}
