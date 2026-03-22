import SwiftUI
import HealthKit
import WatchConnectivity

struct WorkoutView: View {
    @EnvironmentObject var sessionDelegate: WatchSessionDelegate
    @StateObject private var workoutManager = WorkoutManager()
    @State private var showPermissionAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Workout status icon
            Image(systemName: workoutManager.isWorkoutActive ? "figure.run" : "figure.stand")
                .font(.system(size: 40))
                .foregroundColor(workoutManager.isWorkoutActive ? .green : .secondary)
            
            // Heart rate display
            VStack(spacing: 8) {
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(workoutManager.currentHeartRate)")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                    Text("BPM")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                // Heart animation when active
                if workoutManager.isWorkoutActive {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.red)
                        .scaleEffect(workoutManager.heartRateAnimation)
                        .animation(.easeInOut(duration: 0.5), value: workoutManager.heartRateAnimation)
                }
            }
            
            // Duration
            if workoutManager.isWorkoutActive {
                Text(workoutManager.formattedDuration)
                    .font(.system(size: 16, weight: .medium, design: .monospaced))
                    .foregroundColor(.secondary)
            }
            
            // Start/Stop button
            Button(action: toggleWorkout) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(workoutManager.isWorkoutActive ? Color.red : Color.green)
                        .frame(width: 120, height: 50)
                    
                    Text(workoutManager.isWorkoutActive ? "Stop" : "Start")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            // Error message
            if let error = workoutManager.errorMessage {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .onAppear {
            workoutManager.requestAuthorization()
        }
        .alert("HealthKit Access", isPresented: $showPermissionAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Please enable HealthKit access in Settings to track workouts and heart rate.")
        }
    }
    
    private func toggleWorkout() {
        if workoutManager.isWorkoutActive {
            workoutManager.endWorkout()
        } else {
            workoutManager.startWorkout()
        }
    }
}

// MARK: - WorkoutManager with HealthKit

class WorkoutManager: NSObject, ObservableObject {
    private let healthStore = HKHealthStore()
    
    @Published var isWorkoutActive = false
    @Published var currentHeartRate: Int = 0
    @Published var workoutDuration: TimeInterval = 0
    @Published var errorMessage: String?
    @Published var heartRateAnimation: CGFloat = 1.0
    
    private var workoutSession: HKWorkoutSession?
    private var workoutBuilder: HKLiveWorkoutBuilder?
    private var heartRateQuery: HKAnchoredObjectQuery?
    private var durationTimer: Timer?
    private var startTime: Date?
    
    var formattedDuration: String {
        let hours = Int(workoutDuration) / 3600
        let minutes = (Int(workoutDuration) % 3600) / 60
        let seconds = Int(workoutDuration) % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    // HealthKit workout types
    private let workoutTypes: Set<HKSampleType> = [
        HKObjectType.workoutType(),
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
    ]
    
    func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            errorMessage = "HealthKit not available"
            return
        }
        
        healthStore.requestAuthorization(toShare: nil, read: workoutTypes) { success, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func startWorkout() {
        guard HKHealthStore.isHealthDataAvailable() else {
            errorMessage = "HealthKit not available"
            return
        }
        
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .running
        configuration.locationType = .outdoor
        
        do {
            workoutSession = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            workoutBuilder = workoutSession?.associatedWorkoutBuilder()
            
            workoutBuilder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)
            
            workoutSession?.delegate = self
            workoutBuilder?.delegate = self
            
            // Start the workout
            let startDate = Date()
            workoutSession?.startActivity(with: startDate)
            workoutBuilder?.beginCollection(withStart: startDate) { success, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    self.isWorkoutActive = true
                    self.startTime = startDate
                    self.startHeartRateQuery()
                    self.startDurationTimer()
                }
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func endWorkout() {
        workoutSession?.end()
        
        workoutBuilder?.endCollection(withEnd: Date()) { success, error in
            self.workoutBuilder?.finishWorkout { workout, error in
                DispatchQueue.main.async {
                    self.isWorkoutActive = false
                    self.stopHeartRateQuery()
                    self.stopDurationTimer()
                    self.currentHeartRate = 0
                    self.workoutDuration = 0
                }
            }
        }
    }
    
    private func startHeartRateQuery() {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }
        
        let predicate = HKQuery.predicateForSamples(
            withStart: startTime,
            end: nil,
            options: .strictStartDate
        )
        
        heartRateQuery = HKAnchoredObjectQuery(
            type: heartRateType,
            predicate: predicate,
            anchor: nil,
            limit: HKObjectQueryNoLimit
        ) { query, samples, deletedObjects, anchor, error in
            self.updateHeartRate(samples: samples)
        }
        
        heartRateQuery?.updateHandler = { query, samples, deletedObjects, anchor, error in
            self.updateHeartRate(samples: samples)
        }
        
        healthStore.execute(heartRateQuery!)
    }
    
    private func stopHeartRateQuery() {
        if let query = heartRateQuery {
            healthStore.stop(query)
            heartRateQuery = nil
        }
    }
    
    private func updateHeartRate(samples: [HKSample]?) {
        guard let heartRateSamples = samples as? [HKQuantitySample],
              let mostRecent = heartRateSamples.last else { return }
        
        let heartRateUnit = HKUnit.count().unitDivided(by: .minute())
        let heartRate = Int(mostRecent.quantity.doubleValue(for: heartRateUnit))
        
        DispatchQueue.main.async {
            self.currentHeartRate = heartRate
            self.heartRateAnimation = heartRate > 100 ? 1.2 : 1.0
            
            // Send live HR to phone via WCSession
            self.sendHeartRateToPhone(heartRate: heartRate)
        }
    }
    
    private func sendHeartRateToPhone(heartRate: Int) {
        guard WCSession.default.isReachable else { return }
        
        let message: [String: Any] = [
            "action": "liveHeartRate",
            "heartRate": heartRate,
            "timestamp": Date().timeIntervalSince1970
        ]
        
        WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
    }
    
    private func startDurationTimer() {
        durationTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let start = self.startTime {
                DispatchQueue.main.async {
                    self.workoutDuration = Date().timeIntervalSince(start)
                }
            }
        }
    }
    
    private func stopDurationTimer() {
        durationTimer?.invalidate()
        durationTimer = nil
    }
}

// MARK: - HKWorkoutSessionDelegate

extension WorkoutManager: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        DispatchQueue.main.async {
            self.isWorkoutActive = toState == .running
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
            self.isWorkoutActive = false
        }
    }
}

// MARK: - HKLiveWorkoutBuilderDelegate

extension WorkoutManager: HKLiveWorkoutBuilderDelegate {
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        // Handle workout events
    }
    
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else { continue }
            
            let statistics = workoutBuilder.statistics(for: quantityType)
            
            if quantityType == HKObjectType.quantityType(forIdentifier: .heartRate) {
                let heartRateUnit = HKUnit.count().unitDivided(by: .minute())
                let heartRate = statistics?.mostRecentQuantity()?.doubleValue(for: heartRateUnit)
                
                if let hr = heartRate {
                    DispatchQueue.main.async {
                        self.currentHeartRate = Int(hr)
                    }
                }
            }
        }
    }
}

#Preview {
    WorkoutView()
        .environmentObject(WatchSessionDelegate())
}
