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
    
    func fetchRemindersInCalendar(calendar: EKCalendar) {
        if !WCSession.isSupported() { return }
        let session = WCSession.defaultSession()
        let message = MessageManager.remindersRequest()
        if session.reachable {
            session.sendMessage(message, replyHandler: { reply in
                
                }, errorHandler: { error in
                    
            })
        }
        else {
            print("Not reachable");
        }
    }
    
}
