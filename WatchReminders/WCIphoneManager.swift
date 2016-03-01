//
//  WCIphoneManager.swift
//  WatchReminders
//
//  Created by Ivan Grachev on 2/29/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import UIKit
import WatchConnectivity

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
        if MessageManager.typeOfMessage(message) == .RemindersRequest {
            
        }
    }
    
}
