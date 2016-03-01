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
    
    func setupWithCalendar(calendar: EKCalendar) {
        titleLabel.setText(calendar.title)
        titleLabel.setTextColor(UIColor(CGColor: calendar.CGColor))
    }
    
    func setupWithReminder(reminder: Reminder) {
        titleLabel.setText(reminder.title)
    }
}
