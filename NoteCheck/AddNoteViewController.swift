//
//  AddNoteViewController.swift
//  NoteCheck
//
//  Created by assaf yehudai on 2/3/18.
//  Copyright © 2018 assaf yehudai. All rights reserved.
//

import UIKit

protocol AddNoteDelegate: class {
    
    func addNote(note: CheckNoteModel)
    func updateNote(note: CheckNoteModel)
}

class AddNoteViewController: UIViewController {
    
    var isUpdateMode = false
    var tempContnet: String?
    var tempTitle: String?
    
    weak var delegate: AddNoteDelegate?
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var noteContainerView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        noteContainerView.layer.cornerRadius = 3
        doneButton.layer.cornerRadius = 3
        
        if isUpdateMode {
            noteTitle.text = tempTitle!
            content.text = tempContnet!
            doneButton.setTitle("Update", for: .normal)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneButtonTapped(_ sender: UIButton) {
    
        if isUpdateMode {
            updateNote()
        }
        addNote()
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeNote() -> CheckNoteModel {
        return CheckNoteModel(with: noteTitle.text ?? "" , and: content.text ?? "")
    }
    
    func updateNote() {
        delegate?.updateNote(note: makeNote())
    }
    
    func addNote() {
        delegate?.addNote(note: makeNote())
    }
}
