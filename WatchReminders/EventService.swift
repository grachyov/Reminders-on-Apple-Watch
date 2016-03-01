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
    
    func fetchRemindersInCalendar(calendar: EKCalendar, completionHandler:(([EKReminder]) -> Void)) {
        if !NSUserDefaults.standardUserDefaults().accessGranted {
            requestAccess()
            return
        }
        let store = EKEventStore()
        let predicate = store.predicateForRemindersInCalendars([calendar])
        store.fetchRemindersMatchingPredicate(predicate) { (reminders) -> Void in
            guard let reminders = reminders else { return }
            completionHandler(reminders)
        }
    }
    
}
