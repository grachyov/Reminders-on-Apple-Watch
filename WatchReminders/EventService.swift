//
//  EventService.swift
//  WatchReminders
//
//  Created by Ivan Grachev on 2/28/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import UIKit
import EventKit

class EventService: NSObject {

    //TODO: make more elegant check for access
    
    static let sharedService = EventService()
    
    func requestAccess() {
        //TODO: протягивать в реквест доступа completion handler
        let store = EKEventStore()
        store.requestAccessToEntityType(.Reminder) { [unowned self] (granted, error) -> Void in
            if granted {
                NSUserDefaults.standardUserDefaults().accessGranted = true
            }
            else {
                self.requestAccess()
            }
        }
    }
    
    func fetchLists(completionHandler:(([EKCalendar]) -> Void)) {
        if !NSUserDefaults.standardUserDefaults().accessGranted {
            requestAccess()
            return
        }
        completionHandler(EKEventStore().calendarsForEntityType(.Reminder))
    }
    
    func fetchScheduledReminders(completionHandler:(([EKReminder]) -> Void)) {
        if !NSUserDefaults.standardUserDefaults().accessGranted {
            requestAccess()
            return
        }
        let store = EKEventStore()
        let predicate = store.predicateForIncompleteRemindersWithDueDateStarting(NSDate.distantPast(),
            ending: NSDate.distantFuture(),
            calendars: nil)
        fetchRemindersWithPredicate(predicate, completionHandler: completionHandler)
    }
    
    func fetchRemindersInCalendarWithID(calendarID: String, completionHandler:(([EKReminder]) -> Void)) {
        if !NSUserDefaults.standardUserDefaults().accessGranted {
            requestAccess()
            return
        }
        guard let calendar = EKEventStore().calendarWithIdentifier(calendarID) else {
            //TODO:call failed completion handler
            return
        }
        fetchRemindersInCalendar(calendar, completionHandler: completionHandler)
    }
    
    func fetchRemindersInCalendar(calendar: EKCalendar, completionHandler:(([EKReminder]) -> Void)) {
        if !NSUserDefaults.standardUserDefaults().accessGranted {
            requestAccess()
            return
        }
        let store = EKEventStore()
        let predicate = store.predicateForIncompleteRemindersWithDueDateStarting(nil,
            ending: nil,
            calendars: [calendar])
        fetchRemindersWithPredicate(predicate, completionHandler: completionHandler)
    }
    
    private func fetchRemindersWithPredicate(predicate: NSPredicate, completionHandler:(([EKReminder]) -> Void)) {
        let store = EKEventStore()
        store.fetchRemindersMatchingPredicate(predicate) { (reminders) -> Void in
            guard let reminders = reminders else { return }
            completionHandler(reminders)
        }
    }
    
}
