import SwiftUI
import WatchConnectivity

struct QuickLogView: View {
    @EnvironmentObject var sessionDelegate: WatchSessionDelegate
    @State private var isLogging = false
    @State private var showConfirmation = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Water drop icon
            Image(systemName: "drop.fill")
                .font(.system(size: 40))
                .foregroundColor(.blue)
            
            // Current water count
            VStack(spacing: 4) {
                Text("\(sessionDelegate.receivedWaterIntake)")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                Text("glasses today")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            // Quick log button
            Button(action: logWater) {
                ZStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 80, height: 80)
                    
                    if isLogging {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        VStack(spacing: 2) {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                            Text("+1")
                                .font(.system(size: 12, weight: .bold))
                        }
                        .foregroundColor(.white)
                    }
                }
            }
            .disabled(isLogging)
            .buttonStyle(PlainButtonStyle())
            
            // Status text
            if showConfirmation {
                Text("Logged!")
                    .font(.caption)
                    .foregroundColor(.green)
                    .transition(.opacity)
            }
            
            if !sessionDelegate.isReachable {
                Text("Phone not reachable")
                    .font(.caption2)
                    .foregroundColor(.orange)
            }
        }
        .padding()
    }
    
    private func logWater() {
        guard WCSession.default.isReachable else {
            // Fallback: store locally and sync when reachable
            return
        }
        
        isLogging = true
        
        // Use sendMessage for real-time communication
        let message: [String: Any] = [
            "action": "logWater",
            "timestamp": Date().timeIntervalSince1970,
            "amount": 1 // 1 glass
        ]
        
        WCSession.default.sendMessage(message, replyHandler: { response in
            DispatchQueue.main.async {
                isLogging = false
                if let status = response["status"] as? String, status == "waterLogged" {
                    withAnimation {
                        showConfirmation = true
                        sessionDelegate.receivedWaterIntake += 1
                    }
                    // Hide confirmation after delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            showConfirmation = false
                        }
                    }
                }
            }
        }, errorHandler: { error in
            DispatchQueue.main.async {
                isLogging = false
                print("Error sending message: \(error.localizedDescription)")
            }
        })
    }
}

#Preview {
    QuickLogView()
        .environmentObject(WatchSessionDelegate())
}
