import WatchConnectivity
import Foundation

class WatchConnectivityManager: NSObject, WCSessionDelegate, ObservableObject {
    static let shared = WatchConnectivityManager()
    
    @Published var dailySteps: Int = 0
    @Published var waterCount: Int = 0

    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    func addWater() {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(["action": "addDailyWater", "amount": 1], replyHandler: nil) { error in
                print("Error sending message to phone: \(error.localizedDescription)")
            }
        } else {
            // Backup with transferUserInfo if unreachable (sync when connected)
            WCSession.default.transferUserInfo(["action": "addDailyWater", "amount": 1])
        }
        waterCount += 1
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}

    // Receive stats push from Phone
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        if let steps = userInfo["steps"] as? Int {
            DispatchQueue.main.async {
                self.dailySteps = steps
            }
        }
    }
}
