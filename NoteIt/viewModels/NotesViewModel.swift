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
        ApiHandler.getAllNotes { (responseData) in
            if !responseData!.isEmpty{
                DatabaseManager.shareInstance.saveSyncedResponse(dataDict: responseData!)
            }
            self.notesArr = Array((DatabaseManager.shareInstance.realm?.objects(Note.self))! )
            notesData(self.notesArr)
        }
    }
    
    
}
