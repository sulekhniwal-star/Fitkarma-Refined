package com.fitkarma.wear.data

import android.content.Context
import android.util.Log
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.booleanPreferencesKey
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import com.google.android.gms.wearable.PutDataMapRequest
import com.google.android.gms.wearable.Wearable
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

private val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "fitkarma_wear_data")

/**
 * Keys for DataStore preferences
 */
object DataKeys {
    val STEPS = intPreferencesKey("steps")
    val CALORIES = intPreferencesKey("calories")
    val WATER_GLASSES = intPreferencesKey("water_glasses")
    val HEART_RATE = intPreferencesKey("heart_rate")
    val HEART_RATE_ZONE = intPreferencesKey("heart_rate_zone")
    val WORKOUT_ACTIVE = booleanPreferencesKey("workout_active")
    val WORKOUT_TYPE = intPreferencesKey("workout_type")
    val WORKOUT_DURATION = intPreferencesKey("workout_duration")
    val LAST_SYNC_TIME = intPreferencesKey("last_sync_time")
}

/**
 * Manages data synchronization between watch and phone via Wearable Data Layer
 */
class WearableDataClient(private val context: Context) {
    
    companion object {
        private const val TAG = "WearableDataClient"
        
        // Data paths
        const val PATH_ACTIVITY_DATA = "/activity_data"
        const val PATH_WATER_LOG = "/water_log"
        const val PATH_WORKOUT_DATA = "/workout_data"
        
        // Channel for workout events
        const val CHANNEL_WORKOUT = "/workout_channel"
    }

    private val wearableClient by lazy { Wearable.getDataClient(context) }

    /**
     * Send activity data to phone
     */
    suspend fun sendActivityData(
        steps: Int,
        calories: Int,
        heartRate: Int,
        heartRateZone: Int
    ) {
        try {
            val putDataMapRequest = PutDataMapRequest.create(PATH_ACTIVITY_DATA)
                .apply {
                    dataMap.putInt("steps", steps)
                    dataMap.putInt("calories", calories)
                    dataMap.putInt("heart_rate", heartRate)
                    dataMap.putInt("heart_rate_zone", heartRateZone)
                    dataMap.putLong("timestamp", System.currentTimeMillis())
                }
                .asPutDataRequest()
                .setUrgent()

            wearableClient.putDataItem(putDataMapRequest)
            Log.d(TAG, "Activity data sent: steps=$steps, calories=$calories, hr=$heartRate")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to send activity data", e)
        }
    }

    /**
     * Send water log to phone
     * Implements 5-second debounce to prevent duplicate writes
     */
    private var lastWaterLogTime = 0L
    private val WATER_DEBOUNCE_MS = 5000L

    suspend fun sendWaterLog(glasses: Int) {
        val now = System.currentTimeMillis()
        
        // Debounce: only send if 5 seconds have passed
        if (now - lastWaterLogTime < WATER_DEBOUNCE_MS) {
            Log.d(TAG, "Water log debounced")
            return
        }
        lastWaterLogTime = now

        try {
            val putDataMapRequest = PutDataMapRequest.create(PATH_WATER_LOG)
                .apply {
                    dataMap.putInt("glasses", glasses)
                    dataMap.putLong("timestamp", now)
                }
                .asPutDataRequest()
                .setUrgent()

            wearableClient.putDataItem(putDataMapRequest)
            Log.d(TAG, "Water log sent: glasses=$glasses")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to send water log", e)
        }
    }

    /**
     * Send workout data to phone
     */
    suspend fun sendWorkoutData(
        isActive: Boolean,
        workoutType: Int,
        durationMinutes: Int,
        heartRate: Int,
        heartRateZone: Int
    ) {
        try {
            val putDataMapRequest = PutDataMapRequest.create(PATH_WORKOUT_DATA)
                .apply {
                    dataMap.putBoolean("workout_active", isActive)
                    dataMap.putInt("workout_type", workoutType)
                    dataMap.putInt("duration_minutes", durationMinutes)
                    dataMap.putInt("heart_rate", heartRate)
                    dataMap.putInt("heart_rate_zone", heartRateZone)
                    dataMap.putLong("timestamp", System.currentTimeMillis())
                }
                .asPutDataRequest()
                .setUrgent()

            wearableClient.putDataItem(putDataMapRequest)
            Log.d(TAG, "Workout data sent: active=$isActive, type=$workoutType")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to send workout data", e)
        }
    }

    /**
     * Save to local DataStore (for complications)
     */
    suspend fun saveToLocalDataStore(
        steps: Int,
        calories: Int,
        waterGlasses: Int,
        heartRate: Int,
        heartRateZone: Int
    ) {
        context.dataStore.edit { preferences ->
            preferences[DataKeys.STEPS] = steps
            preferences[DataKeys.CALORIES] = calories
            preferences[DataKeys.WATER_GLASSES] = waterGlasses
            preferences[DataKeys.HEART_RATE] = heartRate
            preferences[DataKeys.HEART_RATE_ZONE] = heartRateZone
            preferences[DataKeys.LAST_SYNC_TIME] = System.currentTimeMillis().toInt()
        }
    }

    /**
     * Flow for local data changes
     */
    fun getActivityDataFlow(): Flow<ActivityData> = context.dataStore.data.map { preferences ->
        ActivityData(
            steps = preferences[DataKeys.STEPS] ?: 0,
            calories = preferences[DataKeys.CALORIES] ?: 0,
            waterGlasses = preferences[DataKeys.WATER_GLASSES] ?: 0,
            heartRate = preferences[DataKeys.HEART_RATE] ?: 0,
            heartRateZone = preferences[DataKeys.HEART_RATE_ZONE] ?: 0,
            lastSyncTime = preferences[DataKeys.LAST_SYNC_TIME]?.toLong() ?: 0L
        )
    }
}

/**
 * Data class for activity information
 */
data class ActivityData(
    val steps: Int = 0,
    val calories: Int = 0,
    val waterGlasses: Int = 0,
    val heartRate: Int = 0,
    val heartRateZone: Int = 0,
    val lastSyncTime: Long = 0L
) {
    val stepProgress: Float
        get() = (steps / 10000f).coerceIn(0f, 1f)
    
    val calorieProgress: Float
        get() = (calories / 2000f).coerceIn(0f, 1f)
    
    val heartRateZoneName: String
        get() = when (heartRateZone) {
            0 -> "Rest"
            1 -> "Fat Burn"
            2 -> "Cardio"
            3 -> "Peak"
            else -> "Rest"
        }
}
