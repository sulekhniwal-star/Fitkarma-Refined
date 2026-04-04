import SwiftUI

struct ContentView: View {
    @StateObject private var watchConnectivity = WatchConnectivityManager.shared

    var body: some View {
        VStack {
            Text("FitKarma")
                .font(.headline)
                .foregroundColor(.orange)
            
            // Steps Chart (Simple Text)
            VStack {
                Text("\(watchConnectivity.dailySteps)")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Steps Today")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding()

            HStack {
                // Water Quick-Log Button
                Button(action: {
                    watchConnectivity.addWater()
                }) {
                    VStack {
                        Image(systemName: "drop.fill")
                            .foregroundColor(.blue)
                        Text("+1 Glass")
                            .font(.system(size: 10))
                    }
                }
                .buttonStyle(.bordered)
                .tint(.blue.opacity(0.1))

                // Workout Start Button
                Button(action: {
                    // Logic to start workout (would use HealthKit)
                }) {
                    Image(systemName: "play.fill")
                        .foregroundColor(.green)
                }
                .buttonStyle(.bordered)
                .tint(.green.opacity(0.1))
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
