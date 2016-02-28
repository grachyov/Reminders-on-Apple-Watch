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
    
    //MARK: - InterfaceController lifecycle
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let store = EKEventStore()
        store.requestAccessToEntityType(.Reminder) { (granted, error) -> Void in
            let predicate = store.predicateForRemindersInCalendars(nil)
            store.fetchRemindersMatchingPredicate(predicate) { (remindersArray) -> Void in
                guard let remindersArray = remindersArray else {
                    self.listsTable.setNumberOfRows(1, withRowType: "ListRow")
                    (self.listsTable.rowControllerAtIndex(0) as? ListRowController)?.setupWithTitle("FUCK")
                    return
                }
                self.listsTable.setNumberOfRows(remindersArray.count, withRowType: "ListRow")
                for i in 0..<remindersArray.count {
                    print(remindersArray[i].title)
                    (self.listsTable.rowControllerAtIndex(i) as! ListRowController).setupWithTitle(remindersArray[i].title)
                }
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        pushControllerWithName("Inside List", context: nil)
    }
    
}
