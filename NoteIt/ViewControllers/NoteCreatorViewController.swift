//
//  NoteCreatorViewController.swift
//  NoteIt
//
//  Created by Nikesh Jha on 1/31/19.
//  Copyright © 2019 Nikesh Jha. All rights reserved.
//

import UIKit

class NoteCreatorViewController: UIViewController {
    
    
    @IBOutlet weak var noteTitleTxtField: UITextField!
    @IBOutlet weak var noteDetailsTxtView: UITextView!
    
    var note: Note?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        noteDetailsTxtView.delegate = self
    }
    
    func setupUI(){
        noteTitleTxtField.becomeFirstResponder()
    }
    
    func getMaxNoteId() -> Int{
        let allNotesId: [Int] = Array((DatabaseManager.shareInstance.realm?.objects(Note.self))!).map({ (note)   in
            note.id
        })
        return allNotesId.max() ?? 0
    }
    
}

extension NoteCreatorViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        if note == nil{
            note = Note()
            note?.id = getMaxNoteId() + 1
        }
        try! DatabaseManager.shareInstance.realm?.write {
            note?.todo_title = noteTitleTxtField.text ?? ""
            note?.todo_desc = noteDetailsTxtView.text
            note?.created_date = DateUtils.getDateInString(format: .yyyyMMdd, date: Date())
            DatabaseManager.shareInstance.realm?.create(Note.self, value: note, update: true)
        }
    }
}
