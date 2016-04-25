//
//  RemindersAbstractions.swift
//  WatchReminders
//
//  Created by Ivan Grachev on 2/28/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import Foundation

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

extension NSDate {
    func prettyDescriptionWithDate(withDate: Bool, withTime: Bool) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = withDate ? .ShortStyle : .NoStyle
        dateFormatter.timeStyle = withTime ? .ShortStyle : .NoStyle
        if isToday() {
            dateFormatter.dateStyle = .NoStyle
            if withDate {
                return "Today" + (withTime ? " " : "") + dateFormatter.stringFromDate(self)
            }
            else {
                return dateFormatter.stringFromDate(self)
            }
        }
        else {
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
