import ClockKit

class ComplicationService {
    static let shared = ComplicationService()
    
    private init() {}
    
    // MARK: - Update Complications
    
    func updateComplications(stepCount: Int, goalSteps: Int = 10000) {
        // Store step count in UserDefaults for complication access
        UserDefaults.standard.set(stepCount, forKey: "currentStepCount")
        UserDefaults.standard.set(goalSteps, forKey: "dailyStepGoal")
        
        // Reload complications
        let complications = CLKComplicationServer.sharedInstance().activeComplications ?? []
        
        for complication in complications {
            CLKComplicationServer.sharedInstance().reloadTimeline(for: complication)
        }
    }
    
    // MARK: - Get Current Step Count
    
    func getCurrentStepCount() -> Int {
        return UserDefaults.standard.integer(forKey: "currentStepCount")
    }
    
    func getStepGoal() -> Int {
        let goal = UserDefaults.standard.integer(forKey: "dailyStepGoal")
        return goal > 0 ? goal : 10000
    }
    
    // MARK: - Background Update
    
    func scheduleBackgroundUpdate() {
        // Request background refresh
        // This would be called from the phone app via WatchConnectivity
    }
}
