//
//  ComplicationController.swift
//  WatchReminders
//
//  Created by Ivan Grachev on 26/04/16.
//  Copyright © 2016 Ivan Grachev. All rights reserved.
//

import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {

    let complicationText = "✅"
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        let textProvider = CLKSimpleTextProvider(text: complicationText, shortText:complicationText)
        if complication.family == .UtilitarianSmall {
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.textProvider = textProvider
            handler(template)
        }
        else if complication.family == .ModularSmall {
            let template = CLKComplicationTemplateModularSmallSimpleText()
            template.textProvider = textProvider
            handler(template)
        }
        else if complication.family == .CircularSmall {
            let template = CLKComplicationTemplateCircularSmallSimpleText()
            template.textProvider = textProvider
            handler(template)
        }
    }
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimelineEntry?) -> Void) {
        let textProvider = CLKSimpleTextProvider(text: complicationText, shortText:complicationText)
        if complication.family == .UtilitarianSmall {
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.textProvider = textProvider
            handler(CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template))
        }
        else if complication.family == .ModularSmall {
            let template = CLKComplicationTemplateModularSmallSimpleText()
            template.textProvider = textProvider
            handler(CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template))
        }
        else if complication.family == .CircularSmall {
            let template = CLKComplicationTemplateCircularSmallSimpleText()
            template.textProvider = textProvider
            handler(CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template))
        }
    }
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler(.None)
    }
    
}
