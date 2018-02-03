//
//  ViewController.swift
//  NoteCheck
//
//  Created by assaf yehudai on 1/6/18.
//  Copyright © 2018 assaf yehudai. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var selectedIndex: Int?
    var notes = [CheckNoteModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var addNewNoteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotes()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func fetchNotes() {
        notes = NotesManager.shared.getNotes(with: nil) ?? []
    }

}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteTableViewCell
        
        cell?.noteTitle.text = notes[indexPath.row].title
        cell?.content.text = notes[indexPath.row].content
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "add and edit Segue", sender: self)
    }
}

extension ViewController: AddNoteDelegate {
    
    func addNote(note: CheckNoteModel) {
        NotesManager.shared.addNewNote(note)
        notes.append(note)
    }
    
    func updateNote(note: CheckNoteModel) {
        NotesManager.shared.editNote(note)
        fetchNotes()
    }
}

extension ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? AddNoteViewController {
            vc.delegate = self
            
            guard self == sender as? UITableViewController else { return }
            vc.isUpdateMode = true
            vc.tempTitle = notes[selectedIndex!].title
            vc.tempContnet = notes[selectedIndex!].content
        }
    }
}

