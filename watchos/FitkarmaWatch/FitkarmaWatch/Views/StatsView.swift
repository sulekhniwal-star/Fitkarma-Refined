import SwiftUI

struct StatsView: View {
    @EnvironmentObject var sessionDelegate: WatchSessionDelegate
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
                HStack {
                    Image(systemName: "chart.bar.fill")
                        .foregroundColor(.blue)
                    Text("Your Stats")
                        .font(.headline)
                }
                
                Divider()
                
                // Steps
                StatRow(
                    icon: "figure.walk",
                    title: "Steps",
                    value: "\(sessionDelegate.receivedStepCount)",
                    goal: "/ 10,000",
                    color: .blue
                )
                
                // Water
                StatRow(
                    icon: "drop.fill",
                    title: "Water",
                    value: "\(sessionDelegate.receivedWaterIntake)",
                    goal: "/ 8 glasses",
                    color: .cyan
                )
                
                // Calories
                StatRow(
                    icon: "flame.fill",
                    title: "Calories",
                    value: "\(Int(sessionDelegate.receivedCalories))",
                    goal: "/ 2,000 kcal",
                    color: .orange
                )
                
                // Active Minutes
                StatRow(
                    icon: "timer",
                    title: "Active",
                    value: "\(sessionDelegate.receivedActiveMinutes)",
                    goal: "/ 30 min",
                    color: .green
                )
                
                Divider()
                
                // Sync info
                HStack {
                    Image(systemName: sessionDelegate.isReachable ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                        .foregroundColor(sessionDelegate.isReachable ? .green : .orange)
                    Text(sessionDelegate.isReachable ? "Synced with phone" : "Waiting for sync")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
    }
}

struct StatRow: View {
    let icon: String
    let title: String
    let value: String
    let goal: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)
            
            Text(title)
                .font(.subheadline)
            
            Spacer()
            
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(value)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                Text(goal)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    StatsView()
        .environmentObject(WatchSessionDelegate())
}
