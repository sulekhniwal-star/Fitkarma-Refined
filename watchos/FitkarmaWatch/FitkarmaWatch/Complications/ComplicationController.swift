import ClockKit
import WatchConnectivity

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Complication Configuration
    
    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            // Step Ring - Circular Small
            CLKComplicationDescriptor(
                identifier: "stepRingCircular",
                displayName: "Steps Ring",
                supportedFamilies: [.circularSmall],
                hiddenAssets: []
            ),
            // Step Ring - Modular Small
            CLKComplicationDescriptor(
                identifier: "stepRingModular",
                displayName: "Steps",
                supportedFamilies: [.modularSmall],
                hiddenAssets: []
            ),
            // Step Ring - Graphic Rectangular
            CLKComplicationDescriptor(
                identifier: "stepRingGraphic",
                displayName: "Steps Progress",
                supportedFamilies: [.graphicRectangular, .graphicCircular],
                hiddenAssets: []
            )
        ]
        
        handler(descriptors)
    }
    
    // MARK: - Timeline Configuration
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        
        // Get current step count from UserDefaults (shared with main app)
        let stepCount = UserDefaults.standard.integer(forKey: "currentStepCount")
        let goalSteps = UserDefaults.standard.integer(forKey: "dailyStepGoal")
        
        let actualGoal = goalSteps > 0 ? goalSteps : 10000
        let progress = min(Double(stepCount) / Double(actualGoal), 1.0)
        
        let entry: CLKComplicationTimelineEntry?
        
        switch complication.family {
        case .circularSmall:
            entry = createCircularSmallEntry(stepCount: stepCount, goal: actualGoal, progress: progress, date: Date())
        case .modularSmall:
            entry = createModularSmallEntry(stepCount: stepCount, goal: actualGoal, progress: progress, date: Date())
        case .graphicCircular:
            entry = createGraphicCircularEntry(stepCount: stepCount, goal: actualGoal, progress: progress, date: Date())
        case .graphicRectangular:
            entry = createGraphicRectangularEntry(stepCount: stepCount, goal: actualGoal, progress: progress, date: Date())
        default:
            entry = nil
        }
        
        handler(entry)
    }
    
    // MARK: - Circular Small Complication
    
    private func createCircularSmallEntry(stepCount: Int, goal: Int, progress: Double, date: Date) -> CLKComplicationTimelineEntry? {
        let template = CLKComplicationTemplateCircularSmallRingText()
        template.textProvider = CLKSimpleTextProvider(text: "\(stepCount)")
        template.ringStyle = .closed
        template.ringFraction = Float(progress)
        template.fillColor = .blue
        template.ringColor = .blue
        
        return CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
    }
    
    // MARK: - Modular Small Complication
    
    private func createModularSmallEntry(stepCount: Int, goal: Int, progress: Double, date: Date) -> CLKComplicationTimelineEntry? {
        let template = CLKComplicationTemplateModularSmallRingText()
        template.textProvider = CLKSimpleTextProvider(text: "\(stepCount)")
        template.leadingTextProvider = CLKSimpleTextProvider(text: "Steps")
        template.trailingTextProvider = CLKSimpleTextProvider(text: "/\(goal)")
        template.ringStyle = .closed
        template.ringFraction = Float(progress)
        template.fillColor = .blue
        template.ringColor = .blue
        
        return CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
    }
    
    // MARK: - Graphic Circular Complication
    
    private func createGraphicCircularEntry(stepCount: Int, goal: Int, progress: Double, date: Date) -> CLKComplicationTimelineEntry? {
        let template = CLKComplicationTemplateGraphicCircularClosedGaugeText()
        template.gaugeColor = .blue
        template.gaugeFraction = Float(progress)
        template.centerTextProvider = CLKSimpleTextProvider(text: "\(stepCount)")
        
        return CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
    }
    
    // MARK: - Graphic Rectangular Complication
    
    private func createGraphicRectangularEntry(stepCount: Int, goal: Int, progress: Double, date: Date) -> CLKComplicationTimelineEntry? {
        let template = CLKComplicationTemplateGraphicRectangularTextGauge()
        template.headerTextProvider = CLKSimpleTextProvider(text: "Steps")
        template.bodyTextProvider = CLKSimpleTextProvider(text: "\(stepCount)")
        template.leadingTextProvider = CLKSimpleTextProvider(text: "/\(goal)")
        template.trailingTextProvider = nil
        template.gaugeColor = .blue
        template.gaugeFraction = Float(progress)
        
        return CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
    }
    
    // MARK: - Placeholder Template
    
    func getPlaceholderTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        
        let placeholder: CLKComplicationTemplate?
        
        switch complication.family {
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallRingText()
            template.textProvider = CLKSimpleTextProvider(text: "0")
            template.ringStyle = .closed
            template.ringFraction = 0.0
            template.fillColor = .blue
            placeholder = template
            
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallRingText()
            template.textProvider = CLKSimpleTextProvider(text: "0")
            template.leadingTextProvider = CLKSimpleTextProvider(text: "Steps")
            template.trailingTextProvider = CLKSimpleTextProvider(text: "/10k")
            template.ringStyle = .closed
            template.ringFraction = 0.0
            placeholder = template
            
        case .graphicCircular:
            let template = CLKComplicationTemplateGraphicCircularClosedGaugeText()
            template.gaugeColor = .blue
            template.gaugeFraction = 0.0
            placeholder = template
            
        default:
            placeholder = nil
        }
        
        handler(placeholder)
    }
    
    // MARK: - Timeline Support
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Return end of day
        let calendar = Calendar.current
        let endOfDay = calendar.startOfDay(for: Date()).addingTimeInterval(86400)
        handler(endOfDay)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
}

// MARK: - Complication Data Model

struct StepRingData {
    let stepCount: Int
    let goalSteps: Int
    let progress: Double
    
    static let placeholder = StepRingData(stepCount: 0, goalSteps: 10000, progress: 0.0)
    
    init(stepCount: Int, goalSteps: Int = 10000, progress: Double? = nil) {
        self.stepCount = stepCount
        self.goalSteps = goalSteps
        self.progress = progress ?? min(Double(stepCount) / Double(goalSteps), 1.0)
    }
}
