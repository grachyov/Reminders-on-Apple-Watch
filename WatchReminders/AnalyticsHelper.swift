//
//  AnalyticsHelper.swift
//  WatchReminders
//
//  Created by Ivan Grachev on 3/11/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import Crashlytics

class AnalyticsHelper: NSObject {

    static let sharedHelper = AnalyticsHelper()
    
    func logRemindersListViewed(scheduled: Bool) {
        Answers.logCustomEventWithName("Reminders List Viewed", customAttributes: ["Is Scheduled": scheduled ? "Yes" : "No"])
    }
    
}
