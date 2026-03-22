package com.fitkarma.wear.tiles

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.sp
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import androidx.wear.compose.material.MaterialTheme
import androidx.wear.compose.material.Text
import androidx.wear.compose.material.Timer
import androidx.wear.compose.material.TimerStyle
import androidx.wear.compose.ui.unit.dp
import androidx.wear.compose.ui.unit.sp
import androidx.wear.tiles.LayoutElementBuilders
import androidx.wear.tiles.ModifiersBuilders
import androidx.wear.tiles.ResourceBuilders
import androidx.wear.tiles.TileBuilders
import androidx.wear.tiles.TileService
import androidx.wear.tiles.RequestBuilders
import androidx.wear.tiles.TimelineBuilders
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map

private val Context.dataStore by preferencesDataStore(name = "fitkarma_wear_data")

/**
 * Activity Tile Service for Fitkarma Wear OS
 * Shows: Steps ring, Calories ring, Water counter
 * Tap action: Opens phone app
 */
class FitkarmaActivityTileService : TileService() {

    companion object {
        val STEPS_KEY = intPreferencesKey("steps")
        val CALORIES_KEY = intPreferencesKey("calories")
        val WATER_KEY = intPreferencesKey("water_glasses")
        
        const val TILE_NAME = "Fitkarma Activity"
        const val TILE_TAG = "activity_tile"
    }

    override fun onTileRequest(request: RequestBuilders.TileRequest): ListenableResult {
        return callbackToResult { tileCallback ->
            val context = applicationContext
            val dataStore = context.dataStore
            
            // Get current values
            val prefs = dataStore.data.map { it }.first()
            val steps = prefs[STEPS_KEY] ?: 0
            val calories = prefs[CALORIES_KEY] ?: 0
            val water = prefs[WATER_KEY] ?: 0
            
            val tile = TileBuilders.Tile.Builder()
                .setResourcesVersion("1.0")
                .setTileTimeline(
                    TimelineBuilders.Timeline.Builder()
                        .addTimelineEntry(
                            TimelineBuilders.TimelineEntry.Builder()
                                .setLayout(
                                    LayoutElementBuilders.Layout.Builder()
                                        .setRoot(
                                            createLayout(steps, calories, water)
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

    private fun createLayout(steps: Int, calories: Int, water: Int): LayoutElementBuilders.LayoutElement {
        // Calculate progress (assuming goals: 10000 steps, 2000 cal, 8 glasses)
        val stepProgress = (steps.toFloat() / 10000f).coerceIn(0f, 1f)
        val calorieProgress = (calories.toFloat() / 2000f).coerceIn(0f, 1f)
        
        return LayoutElementBuilders.Column.Builder()
            .addContent(
                LayoutElementBuilders.Text.Builder()
                    .setText("Fitkarma")
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
                LayoutElementBuilders.Row.Builder()
                    .addContent(
                        // Steps indicator
                        LayoutElementBuilders.Column.Builder()
                            .addContent(
                                LayoutElementBuilders.Text.Builder()
                                    .setText("🚶")
                                    .setFontSize(18.sp)
                                    .build()
                            )
                            .addContent(
                                LayoutElementBuilders.Text.Builder()
                                    .setText("$steps")
                                    .setFontStyle(
                                        LayoutElementBuilders.FontStyle.Builder()
                                            .setSize(12.sp)
                                            .build()
                                    )
                                    .build()
                            )
                            .addContent(
                                LayoutElementBuilders.Box.Builder()
                                    .setWidth(LayoutElementBuilders.Dimension.expand())
                                    .setHeight(4.dp)
                                    .setBackground(
                                        LayoutElementBuilders.Background.Builder()
                                            .setColor(
                                                LayoutElementBuilders.ColorProp.Builder()
                                                    .setArgb(0xFF4CAF50.toInt())
                                                    .build()
                                            )
                                            .build()
                                    )
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
                        // Calories indicator
                        LayoutElementBuilders.Column.Builder()
                            .addContent(
                                LayoutElementBuilders.Text.Builder()
                                    .setText("🔥")
                                    .setFontSize(18.sp)
                                    .build()
                            )
                            .addContent(
                                LayoutElementBuilders.Text.Builder()
                                    .setText("$calories")
                                    .setFontStyle(
                                        LayoutElementBuilders.FontStyle.Builder()
                                            .setSize(12.sp)
                                            .build()
                                    )
                                    .build()
                            )
                            .addContent(
                                LayoutElementBuilders.Box.Builder()
                                    .setWidth(LayoutElementBuilders.Dimension.expand())
                                    .setHeight(4.dp)
                                    .setBackground(
                                        LayoutElementBuilders.Background.Builder()
                                            .setColor(
                                                LayoutElementBuilders.ColorProp.Builder()
                                                    .setArgb(0xFFFF9800.toInt())
                                                    .build()
                                            )
                                            .build()
                                    )
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
                        // Water indicator
                        LayoutElementBuilders.Column.Builder()
                            .addContent(
                                LayoutElementBuilders.Text.Builder()
                                    .setText("💧")
                                    .setFontSize(18.sp)
                                    .build()
                            )
                            .addContent(
                                LayoutElementBuilders.Text.Builder()
                                    .setText("$water")
                                    .setFontStyle(
                                        LayoutElementBuilders.FontStyle.Builder()
                                            .setSize(12.sp)
                                            .build()
                                    )
                                    .build()
                            )
                            .build()
                    )
                    .build()
            )
            .build()
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
}
