package com.fitkarma.fitkarma

import androidx.wear.tiles.*
import androidx.wear.tiles.LayoutElementBuilders.*
import androidx.wear.tiles.ResourceBuilders.*
import androidx.wear.tiles.TimelineBuilders.*
import androidx.wear.tiles.TileBuilders.*

class ActivityTileService : TileService() {
    override fun onTileRequest(request: TileBuilders.TileRequest): TileBuilders.Tile {
        val root = Column.Builder()
            .addContent(
                Text.Builder()
                    .setText("FitKarma Activity")
                    .build()
            )
            .addContent(
                Row.Builder()
                    .addContent(
                        CircularProgressIndicator.Builder()
                            .setProgress(0.75f)
                            .setCircularProgressIndicatorStyle(
                                CircularProgressIndicatorStyle.Builder()
                                    .setColor(0xFFFF9500.toInt())
                                    .build()
                            )
                            .build()
                    )
                    .build()
            )
            .build()
            
        val timeline = Timeline.Builder()
            .addTimelineEntry(
                TimelineEntry.Builder()
                    .setLayout(
                        Layout.Builder()
                            .setRoot(root)
                            .build()
                    )
                    .build()
            )
            .build()
            
        return Tile.Builder()
            .setResourcesVersion("1")
            .setTimeline(timeline)
            .build()
    }
    
    override fun onResourcesRequest(request: TileBuilders.ResourcesRequest): TileBuilders.Resources {
        return Resources.Builder()
            .setVersion("1")
            .build()
    }
}
