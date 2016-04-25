//
//  MessageManager.swift
//  WatchReminders
//
//  Created by Ivan Grachev on 3/16/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import EventKit

enum MessageType {
    case RemindersRequest
    case ScheduledRemindersRequest
    case RemindersReply
    case MarkAsCompleted
    case None
}

class MessageManager {
    
    class func typeOfMessage(message: [String : AnyObject]) -> MessageType {
        guard let value = message["Type"] as? String else { return .None }
        switch value {
        case "ScheduledRemindersRequest":
            return .ScheduledRemindersRequest
        case "RemindersRequest":
            return .RemindersRequest
        case "RemindersReply":
            return .RemindersReply
        case "MarkAsCompleted":
            return .MarkAsCompleted
        default:
            return .None
        }
    }
    
    class func markAsCompletedRequest(identifier: String) -> [String : AnyObject] {
        return ["Type" : "MarkAsCompleted", "Identifier" : identifier]
    }
    
    class func reminderID(message: [String : AnyObject]) -> String {
        return message["Identifier"] as! String
    }
    
    class func remindersRequestForCalendar(calendar: EKCalendar) -> [String : AnyObject] {
        return ["Type" : "RemindersRequest", "CalendarID" : calendar.calendarIdentifier]
    }
    
    class func scheduledRemindersRequest() -> [String : AnyObject] {
        return ["Type" : "ScheduledRemindersRequest"]
    }
    
    class func calendarID(message: [String : AnyObject]) -> String {
        return message["CalendarID"] as! String
    }
    
    class func replyRemindersMessage(reminders: [Reminder]) -> [String : AnyObject] {
        let remindersDicts = reminders.map { (reminder) -> [String : AnyObject] in
            var reminderDict:[String : AnyObject] = [ "Title" : reminder.title, "Identifier" : reminder.identifier ]
            if let date = reminder.dueDate {
                reminderDict["Date"] = date
            }
            if let notes = reminder.notes {
                reminderDict["Notes"] = notes
            }
            return reminderDict
        }
        return ["Type" : "RemindersReply", "Reminders" : remindersDicts]
    }
    
    class func remindersForReply(reply: [String : AnyObject]) -> [Reminder] {
        guard let remindersDicts = reply["Reminders"] as? [[String : AnyObject]] else { return [] }
        return remindersDicts.map { (reminderDict) -> Reminder in
            return Reminder(title: reminderDict["Title"]! as! String, dueDate: reminderDict["Date"] as? NSDate, identifier: reminderDict["Identifier"] as! String, notes: reminderDict["Notes"] as? String)
        }
    }
    
}