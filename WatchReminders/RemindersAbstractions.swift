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
    case ScheduledRemindersRequest
    case RemindersReply
    case None
}

class MessageManager {
    
    class func remindersRequestForCalendar(calendar: EKCalendar) -> [String : AnyObject] {
        return ["Type" : "RemindersRequest", "CalendarID" : calendar.calendarIdentifier]
    }
    
    class func scheduledRemindersRequest() -> [String : AnyObject] {
        return ["Type" : "ScheduledRemindersRequest"]
    }
    
    class func typeOfMessage(message: [String : AnyObject]) -> MessageType {
        guard let value = message["Type"] as? String else { return .None }
        switch value {
            case "ScheduledRemindersRequest":
                return .ScheduledRemindersRequest
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
    
    class func replyRemindersMessage(reminders: [Reminder]) -> [String : AnyObject] {
        let remindersDicts = reminders.map { (reminder) -> [String : AnyObject] in
            if let date = reminder.dueDate {
                return ["Title" : reminder.title, "Date" : date]
            }
            else {
                return [ "Title" : reminder.title ]
            }
        }
        return ["Type" : "RemindersReply", "Reminders" : remindersDicts]
    }
    
    class func remindersForReply(reply: [String : AnyObject]) -> [Reminder] {
        guard let remindersDicts = reply["Reminders"] as? [[String : AnyObject]] else { return [] }
        return remindersDicts.map { (reminderDict) -> Reminder in
            return Reminder(title: reminderDict["Title"]! as! String, dueDate: reminderDict["Date"] as? NSDate)
        }
    }
    
}

extension NSDate {
    func prettyDescription() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        if isToday() {
            dateFormatter.dateStyle = .NoStyle
            return "Today " + dateFormatter.stringFromDate(self)
        }
        else {
            dateFormatter.dateStyle = .ShortStyle
            return dateFormatter.stringFromDate(self)
        }
    }
    
    func isToday() -> Bool {
        let calendar = NSCalendar.currentCalendar()
        var components = calendar.components([.Era, .Year, .Month, .Day], fromDate:NSDate())
        let today = calendar.dateFromComponents(components)!
        components = calendar.components([.Era, .Year, .Month, .Day], fromDate:self)
        let otherDate = calendar.dateFromComponents(components)!
        if (today.isEqualToDate(otherDate)) {
            return true
        }
        else {
            return false
        }
    }
}

struct Reminder {
    let title: String
    let dueDate: NSDate?
}