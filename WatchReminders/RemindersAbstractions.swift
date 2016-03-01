//
//  RemindersAbstractions.swift
//  WatchReminders
//
//  Created by Ivan Grachev on 2/28/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import EventKit

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
    case RemindersReply
    case None
}

class MessageManager {
    
    class func remindersRequestForCalendar(calendar: EKCalendar) -> [String : AnyObject] {
        return ["Type" : "RemindersRequest", "CalendarID" : calendar.calendarIdentifier]
    }
    
    class func typeOfMessage(message: [String : AnyObject]) -> MessageType {
        guard let value = message["Type"] as? String else { return .None }
        switch value {
            case "RemindersRequest":
                return .RemindersRequest
            case "RemindersReply":
                return .RemindersReply
            default:
                return .None
        }
    }
    
    class func calendarID(message: [String : AnyObject]) -> String {
        return message["CalendarID"] as! String
    }
    
    class func replyRemindersMessage(titles: [String]) -> [String : AnyObject] {
        return ["Type" : "RemindersReply", "Reminders" : titles]
    }
    
    class func remindersForReply(reply: [String : AnyObject]) -> [Reminder] {
        return (reply["Reminders"] as! [String]).map({ (title) -> Reminder in
            return Reminder(title: title)
        })
    }
    
}

struct Reminder {
    let title: String
}