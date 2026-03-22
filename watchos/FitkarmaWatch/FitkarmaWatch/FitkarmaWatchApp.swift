import SwiftUI
import WatchConnectivity

@main
struct FitkarmaWatchApp: App {
    @StateObject private var sessionDelegate = WatchSessionDelegate()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sessionDelegate)
        }
    }
}

class WatchSessionDelegate: NSObject, WCSessionDelegate, ObservableObject {
    @Published var isReachable = false
    @Published var isCompanionInstalled = false
    @Published var receivedStepCount: Int = 0
    @Published var receivedWaterIntake: Int = 0
    @Published var receivedCalories: Double = 0.0
    @Published var receivedActiveMinutes: Int = 0
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    // MARK: - WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            self.isReachable = session.isReachable
            self.isCompanionInstalled = session.isCompanionAppInstalled
        }
    }
    
    func sessionDidBecomeReachability(_ session: WCSession) {
        DispatchQueue.main.async {
            self.isReachable = true
        }
    }
    
    func sessionDidBecomeUnreachable(_ session: WCSession) {
        DispatchQueue.main.async {
            self.isReachable = false
        }
    }
    
    func sessionDidActivate(_ session: WCSession) {
        DispatchQueue.main.async {
            self.isReachable = session.isReachable
        }
    }
    
    func sessionDeactivate(_ session: WCSession) {
        DispatchQueue.main.async {
            self.isReachable = false
        }
    }
    
    // MARK: - Message Handling (Real-time)
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let steps = message["stepCount"] as? Int {
                self.receivedStepCount = steps
            }
            if let water = message["waterIntake"] as? Int {
                self.receivedWaterIntake = water
            }
            if let calories = message["calories"] as? Double {
                self.receivedCalories = calories
            }
            if let activeMinutes = message["activeMinutes"] as? Int {
                self.receivedActiveMinutes = activeMinutes
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        // Handle message and provide reply
        var response: [String: Any] = [:]
        
        if let action = message["action"] as? String {
            switch action {
            case "logWater":
                // Send confirmation back to phone
                response["status"] = "waterLogged"
                response["timestamp"] = Date().timeIntervalSince1970
            case "getStats":
                response["status"] = "statsReceived"
            default:
                response["status"] = "unknownAction"
            }
        }
        
        replyHandler(response)
    }
    
    // MARK: - Background Data Transfer (transferUserInfo - Battery efficient, not real-time)
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        DispatchQueue.main.async {
            if let steps = userInfo["stepCount"] as? Int {
                self.receivedStepCount = steps
            }
            if let water = userInfo["waterIntake"] as? Int {
                self.receivedWaterIntake = water
            }
            if let calories = userInfo["calories"] as? Double {
                self.receivedCalories = calories
            }
            if let activeMinutes = userInfo["activeMinutes"] as? Int {
                self.receivedActiveMinutes = activeMinutes
            }
        }
    }
}
