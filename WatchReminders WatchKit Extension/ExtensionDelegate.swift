//
//  ExtensionDelegate.swift
//  WatchReminders WatchKit Extension
//
//  Created by Ivan Grachev on 2/28/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    override init() {
        super.init()
        WCWatchManager.sharedManager.setupSession()
    }
    
}
