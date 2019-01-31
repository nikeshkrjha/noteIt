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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

