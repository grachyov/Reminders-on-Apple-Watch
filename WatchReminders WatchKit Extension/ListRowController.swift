//
//  ListRowController.swift
//  WatchReminders
//
//  Created by Ivan Grachev on 2/28/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import WatchKit

class ListRowController: NSObject {

    @IBOutlet var titleLabel: WKInterfaceLabel!
    
    func setupWithTitle(title: String) {
        self.titleLabel.setText(title)
    }
}
