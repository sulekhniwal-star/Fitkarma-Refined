package com.fitkarma.wear.data

import android.content.Intent
import android.util.Log
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import com.google.android.gms.wearable.DataEvent
import com.google.android.gms.wearable.DataEventBuffer
import com.google.android.gms.wearable.DataMapItem
import com.google.android.gms.wearable.WearableListenerService
import kotlinx.coroutines.flow.first

private val Context.dataStore by preferencesDataStore(name = "fitkarma_wear_data")

/**
 * Wearable Data Layer Listener Service
 * Receives data from phone app and updates local DataStore
 * Used for: syncing data from phone, receiving commands
 */
class FitkarmaDataListenerService : WearableListenerService() {

    companion object {
        private const val TAG = "FitkarmaDataListener"
        
        // Data paths
        const val PATH_SYNC_REQUEST = "/sync_request"
        const val PATH_USER_SETTINGS = "/user_settings"
        
        // Keys
        val STEPS = intPreferencesKey("steps")
        val CALORIES = intPreferencesKey("calories")
        val WATER = intPreferencesKey("water_glasses")
        val HEART_RATE = intPreferencesKey("heart_rate")
        val HR_ZONE = intPreferencesKey("heart_rate_zone")
    }

    override fun onDataChanged(dataEvents: DataEventBuffer) {
        super.onDataChanged(dataEvents)
        
        for (event in dataEvents) {
            if (event.type == DataEvent.TYPE_CHANGED) {
                val path = event.dataItem.uri.path
                val dataMap = DataMapItem.fromDataItem(event.dataItem).dataMap
                
                Log.d(TAG, "Received data from path: $path")
                
                when (path) {
                    PATH_SYNC_REQUEST -> handleSyncRequest(dataMap)
                    PATH_USER_SETTINGS -> handleUserSettings(dataMap)
                }
            }
        }
    }

    private fun handleSyncRequest(dataMap: android.os.PersistableBundle) {
        // Phone is requesting a sync - send our current data
        // This is handled by the sensor services
        Log.d(TAG, "Sync request received from phone")
    }

    private fun handleUserSettings(dataMap: android.os.PersistableBundle) {
        // Receive user settings from phone (goals, preferences)
        kotlinx.coroutines.runBlocking {
            dataStore.edit { prefs ->
                dataMap.getInt("daily_step_goal", 10000).let { prefs[STEPS] = it }
                dataMap.getInt("daily_calorie_goal", 2000).let { prefs[CALORIES] = it }
                dataMap.getInt("daily_water_goal", 8).let { prefs[WATER] = it }
            }
        }
        Log.d(TAG, "User settings updated from phone")
    }

    override fun onMessageReceived(messageEvent: com.google.android.gms.wearable.MessageEvent) {
        super.onMessageReceived(messageEvent)
        
        val path = messageEvent.path
        val message = String(messageEvent.data ?: ByteArray(0))
        
        Log.d(TAG, "Message received: $path - $message")
        
        when (path) {
            "/request_sync" -> {
                // Phone requests sync - trigger sensor updates
                Log.d(TAG, "Sync requested by phone")
            }
            "/ping" -> {
                // Keep-alive ping
                Log.d(TAG, "Ping received")
            }
        }
    }

    override fun onPeerConnected(peer: com.google.android.gms.wearable.Node) {
        super.onPeerConnected(peer)
        Log.d(TAG, "Peer connected: ${peer.id}")
    }

    override fun onPeerDisconnected(peer: com.google.android.gms.wearable.Node) {
        super.onPeerDisconnected(peer)
        Log.d(TAG, "Peer disconnected: ${peer.id}")
    }
}

/**
 * Extension to get values from PersistableBundle
 */
fun android.os.PersistableBundle.getInt(key: String, defaultValue: Int = 0): Int {
    return if (containsKey(key)) getInt(key, defaultValue) else defaultValue
}
