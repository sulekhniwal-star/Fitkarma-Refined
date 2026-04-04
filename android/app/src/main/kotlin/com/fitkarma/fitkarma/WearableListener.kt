package com.fitkarma.fitkarma

import android.util.Log
import com.google.android.gms.wearable.DataEvent
import com.google.android.gms.wearable.DataEventBuffer
import com.google.android.gms.wearable.DataMapItem
import com.google.android.gms.wearable.WearableListenerService
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

class WearableListener : WearableListenerService() {

    override fun onDataChanged(dataEvents: DataEventBuffer) {
        for (event in dataEvents) {
            if (event.type == DataEvent.TYPE_CHANGED) {
                val uri = event.dataItem.uri
                if (uri.path == "/water_add") {
                    val dataMap = DataMapItem.fromDataItem(event.dataItem).dataMap
                    val amount = dataMap.getInt("amount")
                    
                    Log.d("WearableListener", "Water added from Watch: $amount")
                    
                    // Notify Flutter side to write to Drift
                    // We need a background engine if the app is not in foreground
                    // For now, assume a method channel if alive
                    notifyFlutter("addDailyWater", mapOf("amount" to amount))
                }
            }
        }
    }

    private fun notifyFlutter(method: String, arguments: Map<String, Any>) {
        // This is a simplified approach. In a production app, 
        // starting a Flutter background engine would ensure data is saved 
        // even if the UI is not present.
        MainActivity.methodChannel?.invokeMethod(method, arguments)
    }
}
