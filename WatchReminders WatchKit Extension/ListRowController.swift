//
//  ListRowController.swift
//  WatchReminders
//
//  Created by Ivan Grachev on 2/28/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import WatchKit
import EventKit


class ListRowController: NSObject {

    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var dueDateLabel: WKInterfaceLabel!
    
    func setupForScheduled() {
        titleLabel.setText("Scheduled")
        titleLabel.setTextColor(UIColor.redColor())
    }
    
    func setupWithCalendar(calendar: EKCalendar) {
        titleLabel.setText(calendar.title)
        titleLabel.setTextColor(UIColor(CGColor: calendar.CGColor))
    }
    
    func setupWithReminder(reminder: Reminder) {
        titleLabel.setText(reminder.title)
        if let date = reminder.dueDate {
            dueDateLabel.setText(date.prettyDescription())
            if date.compare(NSDate()) == .OrderedAscending {
                dueDateLabel.setTextColor(UIColor.redColor())
            }
        }
    }
}
