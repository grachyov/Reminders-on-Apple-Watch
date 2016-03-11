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
            let remindersTitles = reminders.map({ (reminder) -> String in
                return reminder.title
            })
            replyHandler(MessageManager.replyRemindersMessage(remindersTitles))
        }
        if messageType == .RemindersRequest {
            EventService.sharedService.fetchRemindersInCalendarWithID(MessageManager.calendarID(message), completionHandler: completionHandler)
            AnalyticsHelper.sharedHelper.logRemindersListViewed(false)
        }
        else if messageType == .ScheduledRemindersRequest {
            EventService.sharedService.fetchScheduledReminders(completionHandler)
            AnalyticsHelper.sharedHelper.logRemindersListViewed(true)
        }
    }
    
}
