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
    
    override func awakeWithContext(context: AnyObject?) {
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
            WCWatchManager.sharedManager.fetchScheduledReminders(reloadWithReminders)
        }
    }
    
    func reloadWithReminders(reminders: [Reminder]) {
        self.displayedReminders = reminders
        self.remindersTable.setNumberOfRows(reminders.count, withRowType: "ListRow")
        for i in 0..<reminders.count {
            (self.remindersTable.rowControllerAtIndex(i) as! ListRowController).setupWithReminder(reminders[i])
        }
        if reminders.count == 0 {
            self.statusLabel.setHidden(false)
        }
    }
    
}
