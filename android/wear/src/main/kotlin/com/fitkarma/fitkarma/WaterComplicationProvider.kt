package com.fitkarma.fitkarma

import android.app.PendingIntent
import android.content.ComponentName
import android.content.Intent
import android.graphics.drawable.Icon
import androidx.wear.watchface.complications.data.*
import androidx.wear.watchface.complications.datasource.ComplicationRequest
import androidx.wear.watchface.complications.datasource.SuspendingComplicationDataSourceService

class WaterComplicationProvider : SuspendingComplicationDataSourceService() {

    override fun getPreviewData(type: ComplicationType): ComplicationData? {
        return createWaterData(8)
    }

    override suspend fun onComplicationRequest(request: ComplicationRequest): ComplicationData {
        // Return complication data with tap action
        return createWaterData(5)
    }

    private fun createWaterData(count: Int): ComplicationData {
        val intent = Intent("com.fitkarma.fitkarma.WATER_ADD").apply {
            setComponent(ComponentName(this@WaterComplicationProvider, WaterActionReceiver::class.java))
        }
        
        val pendingIntent = PendingIntent.getBroadcast(
            this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder("$count gl").build(),
            contentDescription = PlainComplicationText.Builder("Add 1 glass of water").build()
        )
        .setTitle(PlainComplicationText.Builder("WATER").build())
        .setMonochromaticImage(
            MonochromaticImage.Builder(Icon.createWithResource(this, R.drawable.ic_water)).build()
        )
        .setTapAction(pendingIntent)
        .build()
    }
}
