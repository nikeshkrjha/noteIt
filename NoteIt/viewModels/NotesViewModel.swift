//
//  NotesViewModel.swift
//  NoteIt
//
//  Created by Nikesh Jha on 1/31/19.
//  Copyright © 2019 Nikesh Jha. All rights reserved.
//

import Foundation

public class NotesViewModel {
    var notesArr:[Note] = []{
        didSet{
            
        }
    }
    
    func getNotes(notesData: @escaping ([Note]?) -> Void = { _ in }) {
        //        ApiHandler.getAllNotes { (responseData) in
        //            if !responseData!.isEmpty{
        //                DatabaseManager.sharedInstance.saveSyncedResponse(dataDict: responseData!)
        //            }
        //            self.notesArr = Array((DatabaseManager.sharedInstance.realm?.objects(Note.self))! )
        //            notesData(self.notesArr)
        //        }
        
        ApiHandler.fetchAllNotes { (responseData) in
            debugPrint(responseData!)
            if !responseData!.isEmpty{
                DatabaseManager.sharedInstance.saveSyncedResponse(dataDict: responseData!["data"] as! [String : Any])
            }
            self.notesArr = Array((DatabaseManager.sharedInstance.realm?.objects(Note.self))! )
            notesData(self.notesArr)
        }
        
    }
    
    
    
}
