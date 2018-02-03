//
//  CheckNoteModel.swift
//  NoteCheck
//
//  Created by assaf yehudai on 1/6/18.
//  Copyright © 2018 assaf yehudai. All rights reserved.
//

import Foundation
import RealmSwift

class CheckNoteModel {
    
    let title: String!
    let content: String!
    
    init(with title: String, and content: String) {
        self.title = title
        self.content = content
    }
    
    init(with realmNote: RealmNote) {
        self.title = realmNote.title
        self.content = realmNote.content
        
    }
}
