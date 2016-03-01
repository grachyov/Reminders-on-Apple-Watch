//
//  RemindersAbstractions.swift
//  WatchReminders
//
//  Created by Ivan Grachev on 2/28/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import UIKit

extension NSUserDefaults {
    var accessGranted: Bool {
        get {
            return NSUserDefaults.standardUserDefaults().boolForKey("AccessGranted")
        }
        set {
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "AccessGranted")
        }
    }
}

enum MessageType {
    case RemindersRequest
    case None
}

class MessageManager {
    
    class func remindersRequest() -> [String : AnyObject] {
        return ["Request" : "Reminders"]
    }
    
    class func typeOfMessage(message: [String : AnyObject]) -> MessageType {
        guard let value = message["Request"] as? String else { return .None }
        if value == "Reminders" {
            return .RemindersRequest
        }
        else {
            return .None
        }
    }
}