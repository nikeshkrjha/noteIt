//
//  ViewController.swift
//  NoteIt
//
//  Created by Nikesh Jha on 1/31/19.
//  Copyright © 2019 Nikesh Jha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var notesListTblView: UITableView!
    var notesArr: [Note] = []{
        didSet{
            notesListTblView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotesViewModel().getNotes { (notesArr) in
            self.notesArr = (notesArr ?? []).sorted(by: { (n1, n2) -> Bool in
                n1.id > n2.id
            })
            
        }
    }
    
    @IBAction func didClickAddNew(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.Identifiers.noteCreatorVC) as! NoteCreatorViewController
        navigationController?.show(vc, sender: nil)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.notesCell, for: indexPath) as! NotesTableViewCell
        cell.setData(note: notesArr[indexPath.row])
        setBorderTo(cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        launchNoteEditor(note: notesArr[indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func setBorderTo(cell: NotesTableViewCell){
        cell.noteTitleLbl.superview?.layer.borderColor = UIColor.lightGray.cgColor
        cell.noteTitleLbl.superview?.layer.borderWidth = 1
        cell.noteTitleLbl.superview?.layer.cornerRadius = 8
    }
    
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DatabaseManager.sharedInstance.deleteNote(note: notesArr[indexPath.row])
            // remove the item from the data model
            notesArr = Array(DatabaseManager.sharedInstance.realm!.objects(Note.self))
        }
    }
    
    func launchNoteEditor(note: Note){
        let vc = UIStoryboard(name: Constants.Identifiers.mainSB, bundle: nil).instantiateViewController(withIdentifier: Constants.Identifiers.noteCreatorVC) as! NoteCreatorViewController
        vc.note = note
        navigationController?.pushViewController(vc, animated: true)
    }
}

