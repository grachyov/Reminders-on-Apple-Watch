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
            //TODO: refresh only if displayed data is different
            self.displayedCalendars = calendars
            dispatch_async(dispatch_get_main_queue()) {
                self.listsTable.setNumberOfRows(calendars.count, withRowType: "ListRow")
                for i in 0..<calendars.count {
                    (self.listsTable.rowControllerAtIndex(i) as! ListRowController).setupWithCalendar(calendars[i])
                }
            }
        }
    }

    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        pushControllerWithName("Inside List", context: displayedCalendars[rowIndex])
    }
    
}
