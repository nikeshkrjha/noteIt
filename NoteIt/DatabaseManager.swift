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
    static let sharedInstance: DatabaseManager = DatabaseManager()
    
    private init(){
        realm = try! Realm()
    }
    
    func getRealmPath() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    func saveSyncedResponse(dataDict: [String: Any]){
        print(getRealmPath())
        realm = try! Realm()
        
        for key in dataDict.keys {
            switch(key){
            case "notes":
                try! realm?.write {
                    let objects = dataDict[key] as! [AnyObject]
                    let realmObjects = objects.map { Note(value: $0)}
                    realm?.add(realmObjects, update: true)
                }
                
            case "categories":
                try! realm?.write{
                    let objects = dataDict[key] as! [AnyObject]
                    let realmObjects = objects.map { Category(value: $0)}
                    realm?.add(realmObjects, update: true)
                }
                
            default:
                print("default")
            }
        }
    }
    
    func deleteNote(note: Note){
        try! realm?.write {
            realm?.delete(note)
        }
    }
}
