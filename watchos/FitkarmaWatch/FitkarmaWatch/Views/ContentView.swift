import SwiftUI

struct ContentView: View {
    @EnvironmentObject var sessionDelegate: WatchSessionDelegate
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Dashboard Tab - Shows rings progress
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "heart.circle.fill")
                }
                .tag(0)
            
            // Quick Log Tab - Water logging
            QuickLogView()
                .tabItem {
                    Label("Log Water", systemImage: "drop.fill")
                }
                .tag(1)
            
            // Workout Tab - Start/Stop workout
            WorkoutView()
                .tabItem {
                    Label("Workout", systemImage: "figure.run")
                }
                .tag(2)
            
            // Stats Tab - Shows received stats from phone
            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
                .tag(3)
        }
    }
}

struct DashboardView: View {
    @EnvironmentObject var sessionDelegate: WatchSessionDelegate
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Connection Status
                HStack {
                    Image(systemName: sessionDelegate.isReachable ? "applewatch.radiowaves.left.and.right" : "applewatch.slash")
                        .foregroundColor(sessionDelegate.isReachable ? .green : .red)
                    Text(sessionDelegate.isReachable ? "Connected" : "Disconnected")
                        .font(.caption2)
                }
                
                // Steps Ring
                StepRingView(
                    current: sessionDelegate.receivedStepCount,
                    goal: 10000,
                    title: "Steps",
                    color: .blue
                )
                
                // Water Ring
                WaterRingView(
                    current: sessionDelegate.receivedWaterIntake,
                    goal: 8,
                    title: "Glasses"
                )
                
                // Calories Ring
                CaloriesRingView(
                    current: sessionDelegate.receivedCalories,
                    goal: 2000,
                    title: "Calories"
                )
            }
            .padding()
        }
    }
}

struct StepRingView: View {
    let current: Int
    let goal: Int
    let title: String
    let color: Color
    
    var progress: Double {
        min(Double(current) / Double(goal), 1.0)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                // Background ring
                Circle()
                    .stroke(color.opacity(0.3), lineWidth: 8)
                
                // Progress ring
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(color, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 0.5), value: progress)
                
                // Center text
                VStack(spacing: 2) {
                    Text("\(current)")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    Text("/ \(goal)")
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: 80, height: 80)
            
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

struct WaterRingView: View {
    let current: Int
    let goal: Int
    let title: String
    
    var progress: Double {
        min(Double(current) / Double(goal), 1.0)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .stroke(Color.blue.opacity(0.3), lineWidth: 8)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 0.5), value: progress)
                
                VStack(spacing: 2) {
                    Image(systemName: "drop.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.blue)
                    Text("\(current)")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                }
            }
            .frame(width: 60, height: 60)
            
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

struct CaloriesRingView: View {
    let current: Double
    let goal: Double
    let title: String
    
    var progress: Double {
        min(current / goal, 1.0)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .stroke(Color.orange.opacity(0.3), lineWidth: 8)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.orange, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 0.5), value: progress)
                
                VStack(spacing: 2) {
                    Text("\(Int(current))")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                    Text("/ \(Int(goal))")
                        .font(.system(size: 8))
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: 60, height: 60)
            
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(WatchSessionDelegate())
}
