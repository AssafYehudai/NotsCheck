//
//  NotesManager.swift
//  NoteCheck
//
//  Created by assaf yehudai on 1/6/18.
//  Copyright © 2018 assaf yehudai. All rights reserved.
//

import Foundation
import RealmSwift

class RealmNote: Object {
    
    @objc dynamic var title: String?
    @objc dynamic var content: String?
    
    convenience init(with note: CheckNoteModel) {
        self.init()
        self.title = note.title
        self.content = note.content
    }
}

class NotesManager {
    
    static let shared = NotesManager()
    
    private func defaultRealm() -> Realm? {
        do {
            return try Realm()
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func getNote(_ note: CheckNoteModel) -> RealmNote? {
        
        return defaultRealm()?.objects(RealmNote.self).filter("title == %@ ", note.title).first
    }
    
    func getNotes(with title: String?) -> [CheckNoteModel]? {
        
        var notes = defaultRealm()?.objects(RealmNote.self)
        guard notes != nil else { return nil }
        
        if let title = title {
            notes = notes?.filter("title == %@", title)
        }
        return notes?.map{ CheckNoteModel(with: $0) }
    }
    
    func addNewNote(_ note: CheckNoteModel) {
        try! defaultRealm()?.write {
            defaultRealm()?.add(RealmNote(with: note))
        }
    }
    
    func editNote(_ note: CheckNoteModel) {
        
        if let noteToUpdate = getNote(note) {
            try! defaultRealm()?.write {
                noteToUpdate.title = note.title
                noteToUpdate.content = note.content
            }
        }
    }
    
    func removeNote (_ note: CheckNoteModel) {
        if let noteToDelete = getNote(note) {
            try! defaultRealm()?.write {
                defaultRealm()?.delete(noteToDelete)
            }
        }
    }
}
