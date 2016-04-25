//
//  Reminder.swift
//  WatchReminders
//
//  Created by Ivan Grachev on 3/16/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import Foundation

class Reminder {
    let title: String
    let dueDate: NSDate?
    let identifier: String
    let notes: String?
    
    init(title: String, dueDate: NSDate?, identifier: String, notes: String?) {
        self.title = title
        self.dueDate = dueDate
        self.identifier = identifier
        self.notes = notes
    }
    
    var onlyDateString: String? {
        guard let dueDate = dueDate else { return nil }
        return dueDate.prettyDescriptionWithDate(true, withTime: false)
    }
    
    var entireDateString: String? {
        guard let dueDate = dueDate else { return nil }
        return dueDate.prettyDescriptionWithDate(true, withTime: true)
    }
    
    var onlyTimeString: String? {
        guard let dueDate = dueDate else { return nil }
        return dueDate.prettyDescriptionWithDate(false, withTime: true)
    }
}