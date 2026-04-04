import SwiftUI

@main
struct FitkarmaWatchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
        
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}

class NotificationController: WKUserNotificationInterfaceController {
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
}
