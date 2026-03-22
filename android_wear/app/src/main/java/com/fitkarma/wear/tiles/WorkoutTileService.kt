package com.fitkarma.wear.tiles

import android.content.Context
import android.content.Intent
import android.os.Looper
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.datastore.preferences.core.booleanPreferencesKey
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import androidx.wear.tiles.LayoutElementBuilders
import androidx.wear.tiles.ModifiersBuilders
import androidx.wear.tiles.RequestBuilders
import androidx.wear.tiles.ResourceBuilders
import androidx.wear.tiles.TileBuilders
import androidx.wear.tiles.TileService
import androidx.wear.tiles.TimelineBuilders
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.Priority
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map

private val Context.dataStore by preferencesDataStore(name = "fitkarma_workout_data")

/**
 * Workout Tile Service for Fitkarma Wear OS
 * Shows: Start/Stop workout button, Duration timer, HR zone display
 * Live HR zone via ChannelClient
 */
class WorkoutTileService : TileService() {

    companion object {
        val WORKOUT_ACTIVE = booleanPreferencesKey("workout_active")
        val WORKOUT_TYPE = intPreferencesKey("workout_type")
        val WORKOUT_DURATION = intPreferencesKey("workout_duration")
        val HEART_RATE = intPreferencesKey("heart_rate")
        val HEART_RATE_ZONE = intPreferencesKey("heart_rate_zone")
        
        const val TILE_NAME = "Workout"
        const val ACTION_START_WORKOUT = "com.fitkarma.wear.START_WORKOUT"
        const val ACTION_STOP_WORKOUT = "com.fitkarma.wear.STOP_WORKOUT"
    }

    private var fusedLocationClient: FusedLocationProviderClient? = null
    private var locationCallback: LocationCallback? = null

    override fun onTileRequest(request: RequestBuilders.TileRequest): ListenableResult {
        return callbackToResult { tileCallback ->
            val context = applicationContext
            val dataStore = context.dataStore
            
            // Get current workout state
            val prefs = dataStore.data.map { it }.first()
            val isActive = prefs[WORKOUT_ACTIVE] ?: false
            val duration = prefs[WORKOUT_DURATION] ?: 0
            val heartRate = prefs[HEART_RATE] ?: 0
            val heartRateZone = prefs[HEART_RATE_ZONE] ?: 0
            
            val tile = TileBuilders.Tile.Builder()
                .setResourcesVersion("1.0")
                .setTileTimeline(
                    TimelineBuilders.Timeline.Builder()
                        .addTimelineEntry(
                            TimelineBuilders.TimelineEntry.Builder()
                                .setLayout(
                                    LayoutElementBuilders.Layout.Builder()
                                        .setRoot(
                                            createWorkoutLayout(isActive, duration, heartRate, heartRateZone)
                                        )
                                        .build()
                                )
                                .build()
                        )
                        .build()
                )
                .build()
            
            tileCallback.updateTile(tile)
        }
    }

    private fun createWorkoutLayout(
        isActive: Boolean,
        duration: Int,
        heartRate: Int,
        heartRateZone: Int
    ): LayoutElementBuilders.LayoutElement {
        val hrZoneColor = when (heartRateZone) {
            1 -> 0xFF4CAF50.toInt() // Green - Fat Burn
            2 -> 0xFFFFEB3B.toInt() // Yellow - Cardio
            3 -> 0xFFF44336.toInt() // Red - Peak
            else -> 0xFF9E9E9E.toInt() // Gray - Rest
        }
        
        val hrZoneName = when (heartRateZone) {
            0 -> "Rest"
            1 -> "Fat Burn"
            2 -> "Cardio"
            3 -> "Peak"
            else -> "Rest"
        }

        return LayoutElementBuilders.Column.Builder()
            .addContent(
                LayoutElementBuilders.Text.Builder()
                    .setText(if (isActive) "🏃 Workout Active" else "🏃 Start Workout")
                    .setFontStyle(
                        LayoutElementBuilders.FontStyle.Builder()
                            .setSize(14.sp)
                            .setWeight(LayoutElementBuilders.FontWeight.BOLD)
                            .build()
                    )
                    .setModifiers(
                        ModifiersBuilders.Modifiers.Builder()
                            .setPadding(
                                ModifiersBuilders.Padding.Builder()
                                    .setTop(8.dp)
                                    .build()
                            )
                            .build()
                    )
                    .build()
            )
            .addContent(
                LayoutElementBuilders.Box.Builder()
                    .setHeight(8.dp)
                    .build()
            )
            .addContent(
                LayoutElementBuilders.Text.Builder()
                    .setText("⏱️ ${formatDuration(duration)}")
                    .setFontStyle(
                        LayoutElementBuilders.FontStyle.Builder()
                            .setSize(20.sp)
                            .build()
                    )
                    .build()
            )
            .addContent(
                LayoutElementBuilders.Box.Builder()
                    .setHeight(8.dp)
                    .build()
            )
            .addContent(
                LayoutElementBuilders.Row.Builder()
                    .addContent(
                        LayoutElementBuilders.Text.Builder()
                            .setText("❤️ $heartRate")
                            .setFontStyle(
                                LayoutElementBuilders.FontStyle.Builder()
                                    .setSize(14.sp)
                                    .build()
                            )
                            .build()
                    )
                    .addContent(
                        LayoutElementBuilders.Box.Builder()
                            .setWidth(8.dp)
                            .build()
                    )
                    .addContent(
                        LayoutElementBuilders.Box.Builder()
                            .setWidth(40.dp)
                            .setHeight(16.dp)
                            .setBackground(
                                LayoutElementBuilders.Background.Builder()
                                    .setColor(
                                        LayoutElementBuilders.ColorProp.Builder()
                                            .setArgb(hrZoneColor)
                                            .build()
                                    )
                                    .build()
                            )
                            .build()
                    )
                    .addContent(
                        LayoutElementBuilders.Text.Builder()
                            .setText(hrZoneName)
                            .setFontStyle(
                                LayoutElementBuilders.FontStyle.Builder()
                                    .setSize(10.sp)
                                    .build()
                            )
                            .build()
                    )
                    .build()
            )
            .addContent(
                LayoutElementBuilders.Box.Builder()
                    .setHeight(8.dp)
                    .build()
            )
            .addContent(
                LayoutElementBuilders.Text.Builder()
                    .setText(if (isActive else "Tap to Start")
                    .setFontStyle(
                        LayoutElementBuilders.FontStyle.Builder()
                            .setSize(12.sp)
                            .build()
                    )
                    .build()
            )
            .build()
    }

    private fun formatDuration(minutes: Int): String {
        val hours = minutes / 60
        val mins = minutes % 60
        return if (hours > 0) {
            "${hours}h ${mins}m"
        } else {
            "${mins}m"
        }
    }

    override fun onResourcesRequest(request: RequestBuilders.ResourcesRequest): ListenableResult {
        return callbackToResult { resourceCallback ->
            resourceCallback.updateResources(
                ResourceBuilders.Resources.Builder()
                    .setVersion("1.0")
                    .build()
            )
        }
    }

    /**
     * Start GPS tracking for workout
     */
    fun startWorkoutTracking(workoutType: Int) {
        val context = applicationContext
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(context)
        
        val locationRequest = LocationRequest.Builder(
            Priority.PRIORITY_HIGH_ACCURACY,
            5000L // Update every 5 seconds
        ).build()

        locationCallback = object : LocationCallback() {
            override fun onLocationResult(result: LocationResult) {
                // Process location update
                result.lastLocation?.let { location ->
                    // Save to data store and send to phone
                    kotlinx.coroutines.GlobalScope.launch {
                        context.dataStore.edit { prefs ->
                            prefs[WORKOUT_ACTIVE] = true
                            prefs[WORKOUT_TYPE] = workoutType
                        }
                    }
                }
            }
        }

        try {
            fusedLocationClient?.requestLocationUpdates(
                locationRequest,
                locationCallback!!,
                Looper.getMainLooper()
            )
        } catch (e: SecurityException) {
            // Location permission not granted
        }
    }

    /**
     * Stop GPS tracking
     */
    fun stopWorkoutTracking() {
        locationCallback?.let {
            fusedLocationClient?.removeLocationUpdates(it)
        }
        fusedLocationClient = null
    }

    private object kotlinx {
        object coroutines {
            val GlobalScope = kotlinx.coroutines.GlobalScope
            fun launch(block: suspend () -> Unit) {
                kotlinx.coroutines.GlobalScope.launch { block() }
            }
        }
    }
}
