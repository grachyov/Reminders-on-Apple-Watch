//
//  InsideListInterfaceController.swift
//  WatchReminders
//
//  Created by Ivan Grachev on 2/28/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import WatchKit
import Foundation
import EventKit


class InsideListInterfaceController: WKInterfaceController {

    @IBOutlet var remindersTable: WKInterfaceTable!
    @IBOutlet var statusLabel: WKInterfaceLabel!
    
    var calendar: EKCalendar!
    var displayedReminders: [Reminder] = []
    var scheduled: Bool = false
    
    override func awakeWithContext(context: AnyObject?) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InsideListInterfaceController.reminderMarkedAsCompleted(_:)), name: Constants.markedAsCompletedNotification, object: nil)
        if let calendar = context as? EKCalendar {
            self.calendar = calendar
            setTitle(calendar.title)
            WCWatchManager.sharedManager.fetchRemindersInCalendar(calendar, completionHandler: reloadWithReminders)
        }
        else {
            guard let _ = context as? String else {
                popController()
                return
            }
            setTitle("Scheduled")
            scheduled = true
            WCWatchManager.sharedManager.fetchScheduledReminders(reloadWithReminders)
        }
    }
    
    func reloadWithReminders(reminders: [Reminder]) {
        self.displayedReminders = reminders
        self.remindersTable.setNumberOfRows(reminders.count, withRowType: "ListRow")
        for i in 0..<reminders.count {
            (self.remindersTable.rowControllerAtIndex(i) as! ListRowController).setupWithReminder(reminders[i], fullDate: true)
        }
        if reminders.count == 0 {
            self.statusLabel.setHidden(false)
        }
    }
    
    func reminderMarkedAsCompleted(notification: NSNotification) {
        guard let deletedIdentifier = notification.object as? String else { return }
        guard let index = displayedReminders.indexOf({ $0.identifier == deletedIdentifier }) else { return }
        displayedReminders.removeAtIndex(index)
        remindersTable.removeRowsAtIndexes(NSIndexSet(index: index))
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        (table.rowControllerAtIndex(rowIndex) as? ListRowController)?.toggle()
    }
    
    func dateTitles() -> [String] {
        var dateTitles:[String] = []
        for reminder in self.displayedReminders {
            if let dateString = reminder.onlyDateString {
                if !dateTitles.contains(dateString) {
                    dateTitles.append(dateString)
                }
            }
        }
        return dateTitles
    }
    
}
