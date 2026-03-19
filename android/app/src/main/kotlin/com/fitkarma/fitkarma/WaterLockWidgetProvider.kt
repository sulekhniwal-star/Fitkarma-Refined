package com.fitkarma.fitkarma

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import android.app.PendingIntent
import es.antonborri.home_widget.HomeWidgetPlugin

class WaterLockWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.water_lock_widget)
            
            // Get current water count from HomeWidget
            val widgetData = HomeWidgetPlugin.getData(context)
            val waterGlasses = widgetData.getInt("water_glasses", 0)
            
            views.setTextViewText(R.id.water_count, waterGlasses.toString())
            
            // Create intent to increment water
            val intent = Intent(context, MainActivity::class.java).apply {
                action = "com.fitkarma.INCREMENT_WATER"
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
            }
            
            val pendingIntent = PendingIntent.getActivity(
                context,
                1,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            
            views.setOnClickPendingIntent(R.id.water_count, pendingIntent)
            
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
