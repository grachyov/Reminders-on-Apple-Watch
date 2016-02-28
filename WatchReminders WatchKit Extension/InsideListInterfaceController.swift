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
    
    var calendar: EKCalendar!
    var displayedReminders: [EKReminder] = []
    
    override func awakeWithContext(context: AnyObject?) {
        guard let calendar = context as? EKCalendar else {
            popController()
            return
        }
        self.calendar = calendar
        EventService.sharedService.fetchRemindersInCalendar(calendar, completionHandler: reloadWithReminders)
    }
    
    func reloadWithReminders(reminders: [EKReminder]) {
        self.displayedReminders = reminders
        self.remindersTable.setNumberOfRows(reminders.count, withRowType: "ListRow")
        for i in 0..<reminders.count {
            (self.remindersTable.rowControllerAtIndex(i) as! ListRowController).setupWithReminder(reminders[i])
        }
    }
    
}
