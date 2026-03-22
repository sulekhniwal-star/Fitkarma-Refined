package com.fitkarma.wear.complications

import android.app.PendingIntent
import android.content.ComponentName
import android.content.Intent
import android.graphics.drawable.Icon
import androidx.wear.complications.ComplicationData
import androidx.wear.complications.ComplicationManager
import androidx.wear.complications.ComplicationProviderService
import androidx.wear.complications.ComplicationRequest
import androidx.wear.complications.action.Action
import androidx.wear.complications.action.ActionComponent
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import kotlinx.coroutines.flow.first

private val Context.complicationDataStore by preferencesDataStore(name = "fitkarma_complication_data")

/**
 * Complication Provider for Fitkarma
 * Supports:
 * - Circular Small: Step ring progress
 * - Modular Small: Step + HR zone
 * - Ranged Value: Progress bars
 */
class FitkarmaComplicationService : ComplicationProviderService() {

    companion object {
        const val COMPLICATION_TYPE_STEPS = 1
        const val COMPLICATION_TYPE_WATER = 2
        const val COMPLICATION_TYPE_HR = 3
        
        val STEPS_KEY = intPreferencesKey("steps")
        val WATER_KEY = intPreferencesKey("water_glasses")
        val HEART_RATE_KEY = intPreferencesKey("heart_rate")
        val HR_ZONE_KEY = intPreferencesKey("heart_rate_zone")
        
        // Intent action for tap
        const val ACTION_TAP = "com.fitkarma.wear.COMPLICATION_TAP"
    }

    override fun onComplicationRequest(
        request: ComplicationRequest,
        complicationManager: ComplicationManager
    ) {
        val complicationId = request.complicationInstanceId
        val type = request.complicationType

        // Get current data
        val dataStore = applicationContext.complicationDataStore
        
        kotlinx.coroutines.runBlocking {
            val prefs = dataStore.data.first()
            val steps = prefs[STEPS_KEY] ?: 0
            val water = prefs[WATER_KEY] ?: 0
            val heartRate = prefs[HEART_RATE_KEY] ?: 0
            val hrZone = prefs[HR_ZONE_KEY] ?: 0

            val complicationData = when (type) {
                ComplicationData.TYPE_SHORT_TEXT -> createShortTextComplication(
                    steps, heartRate, hrZone
                )
                ComplicationData.TYPE_SMALL_IMAGE -> createSmallImageComplication(steps)
                ComplicationData.TYPE_RANGED_VALUE -> createRangedValueComplication(steps)
                else -> null
            }

            complicationData?.let {
                complicationManager.updateComplication(complicationId, it)
            }
        }
    }

    private fun createShortTextComplication(
        steps: Int,
        heartRate: Int,
        hrZone: Int
    ): ComplicationData {
        val zoneEmoji = when (hrZone) {
            1 -> "💚"  // Fat Burn
            2 -> "💛"  // Cardio
            3 -> "❤️"  // Peak
            else -> "💙"  // Rest
        }
        
        return ComplicationData.Builder(ComplicationData.TYPE_SHORT_TEXT)
            .setShortText("$steps steps\n$zoneEmoji $heartRate bpm")
            .build()
    }

    private fun createSmallImageComplication(steps: Int): ComplicationData {
        // Calculate progress percentage
        val progress = ((steps.toFloat() / 10000f) * 100).toInt()
        
        return ComplicationData.Builder(ComplicationData.TYPE_SMALL_IMAGE)
            .setSmallImage(
                Icon.createWithResource(
                    applicationContext,
                    android.R.drawable.ic_menu_compass
                )
            )
            .build()
    }

    private fun createRangedValueComplication(steps: Int): ComplicationData {
        val progress = (steps.toFloat() / 10000f).coerceIn(0f, 1f)
        
        return ComplicationData.Builder(ComplicationData.TYPE_RANGED_VALUE)
            .setValue(progress * 100)
            .setMinValue(0f)
            .setMaxValue(100f)
            .setShortText("$steps")
            .build()
    }

    override fun onComplicationActivated(
        complicationInstanceId: Int,
        type: Int,
        complicationManager: ComplicationManager
    ) {
        super.onComplicationActivated(complicationInstanceId, type, complicationManager)
    }

    override fun onComplicationDeactivated(
        complicationInstanceId: Int,
        type: Int
    ) {
        super.onComplicationDeactivated(complicationInstanceId, type)
    }
}

/**
 * Water Complication - Tap to add +1 glass
 * Uses DataClient to write to DataMap, sends to phone with debounce
 */
class WaterComplicationService : ComplicationProviderService() {

    companion object {
        const val COMPLICATION_TYPE_WATER = 100
        
        val WATER_KEY = intPreferencesKey("water_glasses")
        
        // Debounce tracking
        var lastWaterTapTime = 0L
        const val WATER_DEBOUNCE_MS = 5000L
    }

    override fun onComplicationRequest(
        request: ComplicationRequest,
        complicationManager: ComplicationManager
    ) {
        val complicationId = request.complicationInstanceId
        
        // Get current water count
        val dataStore = applicationContext.complicationDataStore
        
        kotlinx.coroutines.runBlocking {
            val prefs = dataStore.data.first()
            val glasses = prefs[WATER_KEY] ?: 0

            // Create complication with tap action
            val action = Action.Builder()
                .setActionComponent(
                    ActionComponent.Builder()
                        .setAndroidActivity(
                            PendingIntent.getService(
                                applicationContext,
                                0,
                                Intent(applicationContext, WaterTapReceiver::class.java),
                                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                            )
                        )
                        .build()
                )
                .build()

            val complicationData = ComplicationData.Builder(ComplicationData.TYPE_SHORT_TEXT)
                .setShortText("💧 $glasses")
                .setTapAction(action)
                .build()

            complicationManager.updateComplication(complicationId, complicationData)
        }
    }
}

/**
 * Receiver for water tap action
 */
class WaterTapReceiver : android.content.BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        val now = System.currentTimeMillis()
        
        // Debounce: 5 second cooldown
        if (now - WaterComplicationService.lastWaterTapTime < WaterComplicationService.WATER_DEBOUNCE_MS) {
            return
        }
        WaterComplicationService.lastWaterTapTime = now
        
        // Increment water count
        context?.let { ctx ->
            val prefs = ctx.complicationDataStore
            kotlinx.coroutines.runBlocking {
                prefs.edit { current ->
                    val currentGlasses = current[WaterComplicationService.WATER_KEY] ?: 0
                    current[WaterComplicationService.WATER_KEY] = currentGlasses + 1
                }
            }
            
            // Send to phone via Wearable Data Layer
            sendToPhone(ctx, (prefs.data.first()[WaterComplicationService.WATER_KEY] ?: 0))
        }
    }
    
    private fun sendToPhone(context: Context, glasses: Int) {
        try {
            val putDataMapRequest = com.google.android.gms.wearable.PutDataMapRequest
                .create("/water_log")
                .apply {
                    dataMap.putInt("glasses", glasses)
                    dataMap.putLong("timestamp", System.currentTimeMillis())
                }
                .asPutDataRequest()
                .setUrgent()
            
            com.google.android.gms.wearable.Wearable.getDataClient(context)
                .putDataItem(putDataMapRequest)
        } catch (e: Exception) {
            // Handle error
        }
    }
}
