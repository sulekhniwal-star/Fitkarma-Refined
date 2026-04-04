package com.fitkarma.fitkarma

import android.graphics.drawable.Icon
import androidx.wear.watchface.complications.data.*
import androidx.wear.watchface.complications.datasource.ComplicationRequest
import androidx.wear.watchface.complications.datasource.ComplicationDataSourceService
import androidx.wear.watchface.complications.datasource.SuspendingComplicationDataSourceService

class StepComplicationProvider : SuspendingComplicationDataSourceService() {

    override fun getPreviewData(type: ComplicationType): ComplicationData? {
        if (type != ComplicationType.RANGED_VALUE && type != ComplicationType.SHORT_TEXT) {
            return null
        }
        return createStepData(8500, 10000)
    }

    override suspend fun onComplicationRequest(request: ComplicationRequest): ComplicationData {
        // In a real app, we would fetch from DataClient or local storage
        // For now, mock data
        return createStepData(7200, 10000)
    }

    private fun createStepData(steps: Int, goal: Int): ComplicationData {
        val progress = (steps.toFloat() / goal.toFloat()).coerceIn(0f, 1f)
        
        return RangedValueComplicationData.Builder(
            value = progress * 100f,
            min = 0f,
            max = 100f,
            contentDescription = PlainComplicationText.Builder("Steps goal progress").build()
        )
        .setText(PlainComplicationText.Builder("${steps/1000}k").build())
        .setTitle(PlainComplicationText.Builder("STEPS").build())
        .setMonochromaticImage(
            MonochromaticImage.Builder(Icon.createWithResource(this, R.drawable.ic_steps)).build()
        )
        .build()
    }
}
