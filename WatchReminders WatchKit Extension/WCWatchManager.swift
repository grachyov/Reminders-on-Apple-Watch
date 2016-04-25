//
//  WCWatchManager.swift
//  WatchReminders
//
//  Created by Ivan Grachev on 2/29/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import WatchKit
import WatchConnectivity
import EventKit

class WCWatchManager: NSObject, WCSessionDelegate {

    static let sharedManager = WCWatchManager()
    
    func setupSession() {
        if WCSession.isSupported() {
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    func fetchScheduledReminders(completionHandler:(([Reminder]) -> Void)) {
        sendRemindersRequest(MessageManager.scheduledRemindersRequest(), completionHandler: completionHandler)
    }
    
    func fetchRemindersInCalendar(calendar: EKCalendar, completionHandler:(([Reminder]) -> Void)) {
        sendRemindersRequest(MessageManager.remindersRequestForCalendar(calendar), completionHandler: completionHandler)
    }
    
    func markAsCompletedReminderWithIdentifier(identifier: String) {
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.markedAsCompletedNotification, object: identifier)
        sendMessage(MessageManager.markAsCompletedRequest(identifier), replyHandler: { reply in }, errorHandler: { error in })
    }
    
    private func sendRemindersRequest(request: [String : AnyObject], completionHandler:(([Reminder]) -> Void)) {
        sendMessage(request, replyHandler: { reply in
            if MessageManager.typeOfMessage(reply) == .RemindersReply {
                completionHandler(MessageManager.remindersForReply(reply))
            }
            },
            errorHandler: { error in }
        )
    }
    
    private func sendMessage(message: [String : AnyObject], replyHandler: (([String : AnyObject]) -> Void), errorHandler: ((NSError) -> Void)) {
        if !WCSession.isSupported() { return }
        let session = WCSession.defaultSession()
        if session.reachable {
            session.sendMessage(message, replyHandler: replyHandler, errorHandler: errorHandler)
        }
        else {
            print("Not reachable");
        }
    }
    
}
