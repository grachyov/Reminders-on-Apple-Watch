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

    @IBOutlet var cellGroup: WKInterfaceGroup!
    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var dueDateLabel: WKInterfaceLabel!
    @IBOutlet var headerDateLabel: WKInterfaceLabel!
    @IBOutlet var completionButton: WKInterfaceButton!

    var reminder: Reminder?
    var completionButtonHidden = true
    
    @IBAction func completionButtonTapped() {
        if let reminder = reminder {
            WCWatchManager.sharedManager.markAsCompletedReminderWithIdentifier(reminder.identifier)
        }
    }
    
    func setupForScheduled() {
        titleLabel.setText("Scheduled")
        titleLabel.setTextColor(UIColor.redColor())
    }
    
    func setupWithCalendar(calendar: EKCalendar) {
        titleLabel.setText(calendar.title)
        titleLabel.setTextColor(UIColor(CGColor: calendar.CGColor))
    }
    
    func setupWithReminder(reminder: Reminder, fullDate: Bool) {
        self.reminder = reminder
        titleLabel.setText(reminder.title)
        if let date = reminder.dueDate {
            if fullDate {
                dueDateLabel.setText(reminder.entireDateString)
            }
            else {
                dueDateLabel.setText(reminder.onlyTimeString)
            }
            if date.compare(NSDate()) == .OrderedAscending {
                dueDateLabel.setTextColor(UIColor.redColor())
            }
        }
    }
    
    func setupWithDateString(dateString: String) {
        cellGroup.setBackgroundColor(UIColor.blackColor())
        headerDateLabel.setText(dateString)
        headerDateLabel.setHidden(false)
        dueDateLabel.setHidden(true)
        titleLabel.setHidden(true)
    }
    
    func toggle() {
        if let _ = reminder {
            completionButton.setHidden(!completionButtonHidden)
            completionButtonHidden = !completionButtonHidden
        }
    }
    
}
