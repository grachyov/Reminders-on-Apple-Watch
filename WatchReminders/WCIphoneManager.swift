//
//  WCIphoneManager.swift
//  WatchReminders
//
//  Created by Ivan Grachev on 2/29/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import WatchConnectivity
import EventKit


class WCIphoneManager: NSObject, WCSessionDelegate {

    static let sharedManager = WCIphoneManager()
    
    func setupSession() {
        if WCSession.isSupported() {
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        let messageType = MessageManager.typeOfMessage(message)
        let completionHandler: [EKReminder] -> Void = { reminders in
            let remindersStructs = reminders.map({ (reminder) -> Reminder in
                return Reminder(title: reminder.title, dueDate: reminder.dueDateComponents?.date)
            })
            replyHandler(MessageManager.replyRemindersMessage(remindersStructs))
        }
        if messageType == .RemindersRequest {
            EventService.sharedService.fetchRemindersInCalendarWithID(MessageManager.calendarID(message), completionHandler: completionHandler)
        }
        else if messageType == .ScheduledRemindersRequest {
            EventService.sharedService.fetchScheduledReminders(completionHandler)
        }
    }
    
}
