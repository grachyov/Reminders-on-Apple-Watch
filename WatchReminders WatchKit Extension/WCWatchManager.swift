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
    
    private func sendRemindersRequest(request: [String : AnyObject], completionHandler:(([Reminder]) -> Void)) {
        if !WCSession.isSupported() { return }
        let session = WCSession.defaultSession()
        if session.reachable {
            session.sendMessage(request, replyHandler: { reply in
                if MessageManager.typeOfMessage(reply) == .RemindersReply {
                    completionHandler(MessageManager.remindersForReply(reply))
                }
                }, errorHandler: { error in
                    
            })
        }
        else {
            print("Not reachable");
        }
    }
    
}
