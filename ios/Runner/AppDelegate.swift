import Flutter
import UIKit
import WatchConnectivity

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate, WCSessionDelegate {
    
    private var session: WCSession?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // Activate WatchConnectivity session
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
        GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    }
    
    // MARK: - WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("WCSession activation error: \(error.localizedDescription)")
        } else {
            print("WCSession activated with state: \(activationState.rawValue)")
        }
    }
    
    // MARK: - Did Receive Message (Real-time)
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        handleMessage(message)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        let response = handleMessage(message)
        replyHandler(response)
    }
    
    // MARK: - Handle Messages from Watch
    
    private func handleMessage(_ message: [String: Any]) -> [String: Any] {
        var response: [String: Any] = [:]
        
        if let action = message["action"] as? String {
            switch action {
            case "logWater":
                // Handle water logging from watch
                let timestamp = message["timestamp"] as? TimeInterval ?? Date().timeIntervalSince1970
                let amount = message["amount"] as? Int ?? 1
                
                // TODO: Update local database and sync to backend
                // For now, send confirmation
                response["status"] = "waterLogged"
                response["timestamp"] = timestamp
                response["waterIntake"] = amount
                
                print("Water logged from watch: \(amount) glasses")
                
            case "liveHeartRate":
                // Handle live heart rate from workout
                if let heartRate = message["heartRate"] as? Int {
                    let timestamp = message["timestamp"] as? TimeInterval ?? Date().timeIntervalSince1970
                    
                    // TODO: Store in HealthKit or send to backend
                    print("Live heart rate from watch: \(heartRate) BPM")
                    
                    response["status"] = "heartRateReceived"
                }
                
            case "getStats":
                // Send current stats to watch
                // TODO: Get from local database or HealthKit
                response["stepCount"] = 5000
                response["waterIntake"] = 4
                response["calories"] = 1500.0
                response["activeMinutes"] = 20
                
            default:
                response["status"] = "unknownAction"
            }
        }
        
        return response
    }
    
    // MARK: - Background Transfer (transferUserInfo - Battery efficient)
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        // This handles background data pushed via transferUserInfo
        // The watch app will receive this even when the phone app is in background
        
        print("Received background user info from watch: \(userInfo)")
        
        // TODO: Process background data from watch
        // This is used for battery-efficient, non-real-time communication
    }
    
    // MARK: - Send Data to Watch
    
    /// Send real-time data to watch using sendMessage (requires watch to be reachable)
    func sendRealTimeDataToWatch(data: [String: Any]) {
        guard let session = session, session.isReachable else {
            print("Watch is not reachable")
            return
        }
        
        session.sendMessage(data, replyHandler: { response in
            print("Watch responded: \(response)")
        }, errorHandler: { error in
            print("Error sending to watch: \(error.localizedDescription)")
        })
    }
    
    /// Send background data to watch using transferUserInfo (battery-efficient, not real-time)
    func sendBackgroundDataToWatch(data: [String: Any]) {
        guard let session = session else { return }
        
        session.transferUserInfo(data)
        print("Background data queued for watch: \(data)")
    }
    
    /// Send complication data to watch
    func sendComplicationDataToWatch(steps: Int, goal: Int) {
        let data: [String: Any] = [
            "stepCount": steps,
            "dailyGoal": goal,
            "timestamp": Date().timeIntervalSince1970
        ]
        
        // Use transferUserInfo for complications as it's battery-efficient
        session?.transferUserInfo(data)
    }
}
