//
//  NotesTableViewCell.swift
//  NoteIt
//
//  Created by Nikesh Jha on 1/31/19.
//  Copyright © 2019 Nikesh Jha. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var noteTitleLbl: UILabel!
    @IBOutlet weak var noteDescLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(note: Note){
        noteDescLbl.text = note.todo_desc!
        noteTitleLbl.text = note.todo_title!
    }
}
