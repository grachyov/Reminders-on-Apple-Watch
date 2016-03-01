//
//  ListsInterfaceController.swift
//  WatchReminders
//
//  Created by Ivan Grachev on 2/28/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import WatchKit
import Foundation
import EventKit


class ListsInterfaceController: WKInterfaceController {

    @IBOutlet var listsTable: WKInterfaceTable!
    
    var displayedCalendars: [EKCalendar] = []
    
    //MARK: - InterfaceController lifecycle
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    override func willActivate() {
        super.willActivate()
        EventService.sharedService.fetchLists { [unowned self] calendars in
            let displayedIDs = self.displayedCalendars.map { $0.title }
            let newIDs = calendars.map { $0.title }
            var shouldUpdateInterface = displayedIDs.count != newIDs.count
            if !shouldUpdateInterface {
                for calendar in calendars {
                    if !self.displayedCalendars.contains(calendar) {
                        shouldUpdateInterface = true
                        break
                    }
                }
            }
            if shouldUpdateInterface {
                self.displayedCalendars = calendars
                dispatch_async(dispatch_get_main_queue()) {
                    self.listsTable.setNumberOfRows(calendars.count + 1, withRowType: "ListRow")
                    for i in 0..<calendars.count + 1 {
                        let rowController = self.listsTable.rowControllerAtIndex(i) as! ListRowController
                        if i == 0 {
                            rowController.setupForScheduled()
                        }
                        else {
                            rowController.setupWithCalendar(calendars[i - 1])
                        }
                    }
                }
            }
        }
    }

    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        if rowIndex == 0 {
            pushControllerWithName("Inside List", context: Constants.scheduledContextString)
        }
        else {
            pushControllerWithName("Inside List", context: displayedCalendars[rowIndex - 1])
        }
    }
    
}
