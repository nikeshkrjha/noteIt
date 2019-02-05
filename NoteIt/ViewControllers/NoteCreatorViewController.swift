//
//  NoteCreatorViewController.swift
//  NoteIt
//
//  Created by Nikesh Jha on 1/31/19.
//  Copyright © 2019 Nikesh Jha. All rights reserved.
//

import UIKit

class NoteCreatorViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var noteTitleTxtField: UITextField!
    @IBOutlet weak var noteDetailsTxtView: UITextView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var lastEditedInfoLbl: UILabel!
    
    //MARK:- Other variables
    var kbHeight: CGFloat = 0
    var note: Note?
    var optionsView: UIView?
    let bottomContainerView = UIView()
    var lastEditedLbl: UILabel = UILabel()
    var showMoreBtn: UIButton = UIButton()
    
    //MARK:- ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bottomContainerView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
        populateDataIfExists()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupUI(){
        noteDetailsTxtView.delegate = self
        noteTitleTxtField.delegate = self
        setupBottomContainerView()
    }
    
    fileprivate func defaultBottomViewConfiguration() {
//        bottomContainerView.backgroundColor = UIColor.darkGray
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomContainerView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        bottomContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.bringSubviewToFront(bottomContainerView)
        
        bottomContainerView.addSubview(showMoreBtn)
        showMoreBtn.setImage(UIImage(named: "moreIcon"), for: .normal)
        showMoreBtn.addTarget(self, action: #selector(self.didClickMoreBtn(_:)), for: .touchUpInside)
        showMoreBtn.tintColor = UIColor.darkGray
        showMoreBtn.translatesAutoresizingMaskIntoConstraints = false
        showMoreBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        showMoreBtn.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: 0).isActive = true
        showMoreBtn.leadingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -45).isActive = true
        showMoreBtn.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor, constant: 0).isActive = true
        showMoreBtn.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 0).isActive = true
        
        bottomContainerView.addSubview(lastEditedLbl)
        lastEditedLbl.translatesAutoresizingMaskIntoConstraints = false
        lastEditedLbl.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        lastEditedLbl.heightAnchor.constraint(equalToConstant: 45).isActive = true
        lastEditedLbl.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor).isActive = true
        lastEditedLbl.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor, constant: 0).isActive = true
        lastEditedLbl.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 0).isActive = true
        lastEditedLbl.textAlignment = .center
        lastEditedLbl.textColor = UIColor.darkGray
//        lastEditedLbl.backgroundColor = UIColor.green
        
        bottomContainerView.bringSubviewToFront(lastEditedLbl)
        bottomContainerView.bringSubviewToFront(showMoreBtn)
    }
    
    func setupBottomContainerView(){
        defaultBottomViewConfiguration()
    }
    
    func populateDataIfExists(){
        if note != nil{
            noteTitleTxtField.text = note!.todo_title
            noteDetailsTxtView.text = note!.todo_desc
//            lastEditedInfoLbl.text = "Edited " + (note!.updated_date ?? note!.created_date!)
            lastEditedLbl.text = "Edited " + (note!.updated_date ?? note!.created_date!)
        }
    }
    
    //MARK:- Handle keyboard show/hide for adjusting bottom view's y position
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            kbHeight = keyboardRectangle.height
//            bottomContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -kbHeight).isActive = true
            
            if optionsView != nil{
                showHideOptionsView(show: false)
            }
        }
    }
    
    @objc func keyboardWillDisappear(_ notification: Notification){
        view.bringSubviewToFront(bottomContainerView)
        
        NSLayoutConstraint.deactivate(bottomContainerView.constraints)
        let anchor = bottomContainerView.bottomAnchor
        anchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = false
//        bottomContainerView.setNeedsLayout()
    }
    
    //MARK:- get id for newly added note
    func getMaxNoteId() -> Int{
        let allNotesId: [Int] = Array((DatabaseManager.sharedInstance.realm?.objects(Note.self))!).map({ (note)   in
            note.id
        })
        return allNotesId.max() ?? 0
    }
    
    func updateNoteInstance(){
        if note == nil{
            note = Note()
            note?.id = getMaxNoteId() + 1
        }
    }
    
    
    //MARK:- Show/hide options View
    func showHideOptionsView(show: Bool){
        if show{
            noteTitleTxtField.resignFirstResponder()
            noteDetailsTxtView.resignFirstResponder()
        }
        let optionsHeight: CGFloat = 400
        if optionsView == nil {
            optionsView = UIView(frame: CGRect(x: 0, y: self.view.frame.height - bottomContainerView.frame.height, width: self.view.frame.width, height: optionsHeight))
            optionsView!.backgroundColor = UIColor.green
            optionsView!.alpha = 0.7
        }
        
        
        UIView.animate(withDuration: 0.15, animations: {
            if show{
                self.view.addSubview(self.optionsView!)
                self.optionsView!.frame.origin.y -= optionsHeight
                self.view.bringSubviewToFront(self.optionsView!)
            }else{
                self.optionsView!.frame.origin.y += optionsHeight + self.bottomContainerView.frame.height
                print(self.optionsView!.frame)
            }
        }) { (true) in
            if !show{
                self.optionsView!.removeFromSuperview()
                self.optionsView = nil
            }
            
        }
    }
    
    //MARK:- IBAction Methods
    @IBAction func didPressMoreBtn(_ sender: Any) {
//        bottomContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        if optionsView == nil {
//            showHideOptionsView(show: true)
//        }else{
//            showHideOptionsView(show: false)
//        }
        
    }
    
    //The target function
    @objc func didClickMoreBtn(_ sender: UIButton){ //<- needs `@objc`
        noteDetailsTxtView.resignFirstResponder()
        bottomContainerView.removeConstraints(bottomContainerView.constraints)
        
        
//        bottomContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -kbHeight).isActive = false
//        bottomContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//        bottomContainerView.setNeedsLayout()
        
         defaultBottomViewConfiguration()
//        view.bringSubviewToFront(bottomContainerView)
        
        
//        noteTitleTxtField.resignFirstResponder()
        
        
        if optionsView == nil {
            showHideOptionsView(show: true)
        }else{
            showHideOptionsView(show: false)
        }
    }
    
}

//MARK:- TextView Delegate
extension NoteCreatorViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        updateNoteInstance()
        try! DatabaseManager.sharedInstance.realm?.write {
            note?.todo_title = noteTitleTxtField.text ?? ""
            note?.todo_desc = noteDetailsTxtView.text
            if note!.created_date!.isEmpty {
                note?.created_date = DateUtils.getDateInString(format: .yyyyMMdd, date: Date())
            }
            note?.updated_date = DateUtils.getDateInString(format: .yyyyMMdd, date: Date())
            DatabaseManager.sharedInstance.realm?.create(Note.self, value: note!, update: true)
        }
    }
    

}


extension NoteCreatorViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(bottomContainerView.frame)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        view.bringSubviewToFront(bottomContainerView)
        updateNoteInstance()
        try! DatabaseManager.sharedInstance.realm?.write {
            note?.todo_title = noteTitleTxtField.text ?? ""
            note?.todo_desc = noteDetailsTxtView.text
            if note!.created_date!.isEmpty {
                note?.created_date = DateUtils.getDateInString(format: .yyyyMMdd, date: Date())
            }
            note?.updated_date = DateUtils.getDateInString(format: .yyyyMMdd, date: Date())
            DatabaseManager.sharedInstance.realm?.create(Note.self, value: note!, update: true)
        }
        return true
    }
}
