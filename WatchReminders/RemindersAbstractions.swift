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