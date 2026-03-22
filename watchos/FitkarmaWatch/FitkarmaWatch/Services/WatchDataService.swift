import Foundation
import WatchConnectivity
import ClockKit

class WatchDataService: NSObject {
    static let shared = WatchDataService()
    
    private override init() {
        super.init()
    }
    
    // MARK: - Handle Background User Info (transferUserInfo - Battery efficient, not real-time)
    
    func handleUserInfo(_ userInfo: [String: Any]) {
        // Extract data from background transfer
        if let stepCount = userInfo["stepCount"] as? Int {
            UserDefaults.standard.set(stepCount, forKey: "currentStepCount")
            // Update complications
            ComplicationService.shared.updateComplications(
                stepCount: stepCount,
                goalSteps: UserDefaults.standard.integer(forKey: "dailyStepGoal")
            )
        }
        
        if let waterIntake = userInfo["waterIntake"] as? Int {
            UserDefaults.standard.set(waterIntake, forKey: "currentWaterIntake")
        }
        
        if let calories = userInfo["calories"] as? Double {
            UserDefaults.standard.set(calories, forKey: "currentCalories")
        }
        
        if let activeMinutes = userInfo["activeMinutes"] as? Int {
            UserDefaults.standard.set(activeMinutes, forKey: "currentActiveMinutes")
        }
        
        // Post notification for UI update
        NotificationCenter.default.post(name: .healthDataUpdated, object: nil)
    }
    
    // MARK: - Handle Real-time Messages (sendMessage - Real-time)
    
    func handleMessage(_ message: [String: Any]) -> [String: Any]? {
        var response: [String: Any] = [:]
        
        if let action = message["action"] as? String {
            switch action {
            case "logWater":
                // Increment water count locally
                let currentWater = UserDefaults.standard.integer(forKey: "currentWaterIntake")
                let newWater = currentWater + 1
                UserDefaults.standard.set(newWater, forKey: "currentWaterIntake")
                
                response["status"] = "success"
                response["waterIntake"] = newWater
                
                // Notify UI
                NotificationCenter.default.post(name: .healthDataUpdated, object: nil)
                
            case "getStats":
                // Return current stats
                response["stepCount"] = UserDefaults.standard.integer(forKey: "currentStepCount")
                response["waterIntake"] = UserDefaults.standard.integer(forKey: "currentWaterIntake")
                response["calories"] = UserDefaults.standard.double(forKey: "currentCalories")
                response["activeMinutes"] = UserDefaults.standard.integer(forKey: "currentActiveMinutes")
                
            case "updateSteps":
                if let steps = message["stepCount"] as? Int {
                    UserDefaults.standard.set(steps, forKey: "currentStepCount")
                    ComplicationService.shared.updateComplications(
                        stepCount: steps,
                        goalSteps: UserDefaults.standard.integer(forKey: "dailyStepGoal")
                    )
                    NotificationCenter.default.post(name: .healthDataUpdated, object: nil)
                }
                
            case "liveHeartRate":
                // Handle live heart rate from workout
                if let heartRate = message["heartRate"] as? Int {
                    UserDefaults.standard.set(heartRate, forKey: "currentHeartRate")
                    NotificationCenter.default.post(name: .heartRateUpdated, object: nil)
                }
                
            default:
                response["status"] = "unknownAction"
            }
        }
        
        return response
    }
}

// MARK: - Notification Names

extension Notification.Name {
    static let healthDataUpdated = Notification.Name("healthDataUpdated")
    static let heartRateUpdated = Notification.Name("heartRateUpdated")
}
