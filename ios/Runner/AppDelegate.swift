import Flutter
import UIKit
import WatchConnectivity

@main
@objc class AppDelegate: FlutterAppDelegate, WCSessionDelegate, FlutterImplicitEngineDelegate {
  
  var methodChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    methodChannel = FlutterMethodChannel(name: "com.fitkarma.wear",
                                              binaryMessenger: controller.binaryMessenger)
    
    // Initialize WCSession
    if WCSession.isSupported() {
        let session = WCSession.default
        session.delegate = self
        session.activate()
    }
    
    methodChannel?.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "pushStatsToWatch" {
          self.pushStatsToWatch(arguments: call.arguments)
          result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func pushStatsToWatch(arguments: Any?) {
      guard let dict = arguments as? [String : Any] else { return }
      if WCSession.default.activationState == .activated {
          WCSession.default.transferUserInfo(dict)
      }
  }

  // MARK: WCSessionDelegate
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
      print("WCSession activation state: \(activationState.rawValue)")
  }
  
  func sessionDidBecomeInactive(_ session: WCSession) {}
  func sessionDidDeactivate(_ session: WCSession) {
      session.activate()
  }
  
  // Receive message from Apple Watch
  func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
      if let action = message["action"] as? String {
          DispatchQueue.main.async {
              if action == "addDailyWater" {
                  let amount = message["amount"] as? Int ?? 1
                  self.methodChannel?.invokeMethod("addDailyWater", arguments: ["amount": amount])
              } else if action == "startWorkout" {
                  self.methodChannel?.invokeMethod("startWorkout", arguments: nil)
              }
          }
      }
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
