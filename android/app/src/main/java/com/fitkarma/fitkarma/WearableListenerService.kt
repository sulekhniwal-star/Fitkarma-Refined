package com.fitkarma.fitkarma

import android.content.Intent
import android.util.Log
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import com.fitkarma.core.storage.drift_database.AppDatabase
import com.google.android.gms.wearable.DataEvent
import com.google.android.gms.wearable.DataEventBuffer
import com.google.android.gms.wearable.DataMapItem
import com.google.android.gms.wearable.MessageEvent
import com.google.android.gms.wearable.WearableListenerService
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch

/**
 * WearableListenerService on the phone
 * Receives events from the watch and writes to Drift database
 * Implements idempotent writes with 5-second debounce for water logs
 */
class WearableListenerService : WearableListenerService() {

    companion object {
        private const val TAG = "WearableListener"
        
        // Data paths from watch
        const val PATH_ACTIVITY_DATA = "/activity_data"
        const val PATH_WATER_LOG = "/water_log"
        const val PATH_WORKOUT_DATA = "/workout_data"
        
        // Action for local broadcast to Flutter
        const val ACTION_WEARABLE_DATA = "com.fitkarma.WEARABLE_DATA"
        
        // Extra keys
        const val EXTRA_DATA_TYPE = "data_type"
        const val EXTRA_STEPS = "steps"
        const val EXTRA_CALORIES = "calories"
        const val EXTRA_WATER = "water_glasses"
        const val EXTRA_HEART_RATE = "heart_rate"
        const val EXTRA_HR_ZONE = "heart_rate_zone"
        const val EXTRA_WORKOUT_ACTIVE = "workout_active"
        const val EXTRA_WORKOUT_TYPE = "workout_type"
        const val EXTRA_WORKOUT_DURATION = "workout_duration"
        
        // Debounce tracking for water logs
        private var lastWaterLogTime = 0L
        private var lastWaterGlasses = 0
        private const val WATER_DEBOUNCE_MS = 5000L
    }

    private val serviceScope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
    private var database: AppDatabase? = null

    override fun onCreate() {
        super.onCreate()
        // Initialize database
        // Note: In production, use proper DI
        Log.d(TAG, "WearableListenerService created")
    }

    override fun onDataChanged(dataEvents: DataEventBuffer) {
        super.onDataChanged(dataEvents)
        
        Log.d(TAG, "Data changed received: ${dataEvents.count()} events")
        
        for (event in dataEvents) {
            if (event.type == DataEvent.TYPE_CHANGED) {
                val path = event.dataItem.uri.path
                val dataMap = DataMapItem.fromDataItem(event.dataItem).dataMap
                
                Log.d(TAG, "Processing data from path: $path")
                
                when (path) {
                    PATH_ACTIVITY_DATA -> handleActivityData(dataMap)
                    PATH_WATER_LOG -> handleWaterLog(dataMap)
                    PATH_WORKOUT_DATA -> handleWorkoutData(dataMap)
                }
            } else if (event.type == DataEvent.TYPE_DELETED) {
                Log.d(TAG, "Data deleted: ${event.dataItem.uri.path}")
            }
        }
    }

    private fun handleActivityData(dataMap: android.os.PersistableBundle) {
        val steps = dataMap.getInt("steps", 0)
        val calories = dataMap.getInt("calories", 0)
        val heartRate = dataMap.getInt("heart_rate", 0)
        val heartRateZone = dataMap.getInt("heart_rate_zone", 0)
        
        Log.d(TAG, "Activity data: steps=$steps, calories=$calories, hr=$heartRate")
        
        // Save to local database
        serviceScope.launch {
            saveActivityDataToDatabase(steps, calories, heartRate, heartRateZone)
        }
        
        // Broadcast to Flutter
        broadcastToFlutter(EXTRA_DATA_TYPE, "activity", mapOf(
            EXTRA_STEPS to steps,
            EXTRA_CALORIES to calories,
            EXTRA_HEART_RATE to heartRate,
            EXTRA_HR_ZONE to heartRateZone
        ))
    }

    private fun handleWaterLog(dataMap: android.os.PersistableBundle) {
        val glasses = dataMap.getInt("glasses", 0)
        val timestamp = dataMap.getLong("timestamp", System.currentTimeMillis())
        
        // Debounce: Only process if different value or after 5 seconds
        val now = System.currentTimeMillis()
        if (glasses == lastWaterGlasses && (now - lastWaterLogTime) < WATER_DEBOUNCE_MS) {
            Log.d(TAG, "Water log debounced: $glasses glasses")
            return
        }
        
        lastWaterLogTime = now
        lastWaterGlasses = glasses
        
        Log.d(TAG, "Water log: $glasses glasses")
        
        // Save to local database (idempotent)
        serviceScope.launch {
            saveWaterLogToDatabase(glasses, timestamp)
        }
        
        // Broadcast to Flutter
        broadcastToFlutter(EXTRA_DATA_TYPE, "water", mapOf(
            EXTRA_WATER to glasses
        ))
    }

    private fun handleWorkoutData(dataMap: android.os.PersistableBundle) {
        val isActive = dataMap.getBoolean("workout_active", false)
        val workoutType = dataMap.getInt("workout_type", 0)
        val durationMinutes = dataMap.getInt("duration_minutes", 0)
        val heartRate = dataMap.getInt("heart_rate", 0)
        val heartRateZone = dataMap.getInt("heart_rate_zone", 0)
        
        Log.d(TAG, "Workout data: active=$isActive, type=$workoutType, duration=$durationMinutes")
        
        // Save to local database
        serviceScope.launch {
            saveWorkoutDataToDatabase(isActive, workoutType, durationMinutes, heartRate, heartRateZone)
        }
        
        // Broadcast to Flutter
        broadcastToFlutter(EXTRA_DATA_TYPE, "workout", mapOf(
            EXTRA_WORKOUT_ACTIVE to isActive,
            EXTRA_WORKOUT_TYPE to workoutType,
            EXTRA_WORKOUT_DURATION to durationMinutes,
            EXTRA_HEART_RATE to heartRate,
            EXTRA_HR_ZONE to heartRateZone
        ))
    }

    override fun onMessageReceived(messageEvent: MessageEvent) {
        super.onMessageReceived(messageEvent)
        
        val path = messageEvent.path
        val message = String(messageEvent.data ?: ByteArray(0))
        
        Log.d(TAG, "Message received: $path - $message")
        
        when (path) {
            "/ping" -> {
                // Respond to ping from watch
                Log.d(TAG, "Received ping from watch")
            }
            "/request_data" -> {
                // Watch is requesting current data from phone
                // This would be handled by sending data to the watch
                Log.d(TAG, "Watch requested data from phone")
            }
        }
    }

    override fun onPeerConnected(peer: com.google.android.gms.wearable.Node) {
        super.onPeerConnected(peer)
        Log.d(TAG, "Watch connected: ${peer.displayName}")
    }

    override fun onPeerDisconnected(peer: com.google.android.gms.wearable.Node) {
        super.onPeerDisconnected(peer)
        Log.d(TAG, "Watch disconnected: ${peer.displayName}")
    }

    // ==================== Database Operations ====================
    
    private suspend fun saveActivityDataToDatabase(
        steps: Int,
        calories: Int,
        heartRate: Int,
        heartRateZone: Int
    ) {
        // TODO: Implement actual database save
        // This would write to StepLogs, BodyMeasurements tables
        Log.d(TAG, "Saving activity data to database")
    }

    private suspend fun saveWaterLogToDatabase(glasses: Int, timestamp: Long) {
        // TODO: Implement actual database save
        // This would write to WaterLogs table
        // Idempotent: check if similar log exists within 5 minutes
        Log.d(TAG, "Saving water log to database: $glasses glasses")
    }

    private suspend fun saveWorkoutDataToDatabase(
        isActive: Boolean,
        workoutType: Int,
        durationMinutes: Int,
        heartRate: Int,
        heartRateZone: Int
    ) {
        // TODO: Implement actual database save
        // This would write to WorkoutLogs table
        Log.d(TAG, "Saving workout data: active=$isActive, duration=$durationMinutes")
    }

    // ==================== Broadcast ====================

    private fun broadcastToFlutter(dataType: String, extraData: Map<String, Any>) {
        val intent = Intent(ACTION_WEARABLE_DATA).apply {
            putExtra(EXTRA_DATA_TYPE, dataType)
            extraData.forEach { (key, value) ->
                when (value) {
                    is Int -> putExtra(key, value)
                    is Boolean -> putExtra(key, value)
                    is String -> putExtra(key, value)
                }
            }
        }
        LocalBroadcastManager.getInstance(this).sendBroadcast(intent)
    }

    override fun onDestroy() {
        super.onDestroy()
        database?.close()
    }
}

/**
 * Extension to get values from PersistableBundle
 */
fun android.os.PersistableBundle.getInt(key: String, defaultValue: Int = 0): Int {
    return if (containsKey(key)) getInt(key, defaultValue) else defaultValue
}

fun android.os.PersistableBundle.getBoolean(key: String, defaultValue: Boolean = false): Boolean {
    return if (containsKey(key)) getBoolean(key, defaultValue) else defaultValue
}

fun android.os.PersistableBundle.getLong(key: String, defaultValue: Long = 0L): Long {
    return if (containsKey(key)) getLong(key, defaultValue) else defaultValue
}
