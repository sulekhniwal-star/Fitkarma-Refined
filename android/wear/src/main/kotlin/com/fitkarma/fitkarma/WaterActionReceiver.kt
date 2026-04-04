package com.fitkarma.fitkarma

import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.google.android.gms.wearable.DataMap
import com.google.android.gms.wearable.PutDataMapRequest
import com.google.android.gms.wearable.Wearable

class WaterActionReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == "com.fitkarma.fitkarma.WATER_ADD") {
            // Write to DataClient
            val dataClient = Wearable.getDataClient(context)
            val putDataMapReq = PutDataMapRequest.create("/water_add")
            
            // Add unique timestamp to trigger actual data update
            putDataMapReq.dataMap.putLong("timestamp", System.currentTimeMillis())
            putDataMapReq.dataMap.putInt("amount", 1) // +1 glass
            
            val putDataReq = putDataMapReq.asPutDataRequest()
            putDataReq.setUrgent()
            
            dataClient.putData(putDataReq)
            
            // We could update the complication here if we had the request key
        }
    }
}
