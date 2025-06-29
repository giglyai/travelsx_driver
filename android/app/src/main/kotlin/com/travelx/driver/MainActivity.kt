package com.travelx.driver

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.media.AudioAttributes
import android.net.Uri
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "api_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "setApiKey") {
                    val apiKey: String? = call.argument("apiKey")
                    if (!apiKey.isNullOrEmpty()) {
                        storeApiKey(apiKey)
                        setApiKeyInManifest(apiKey)
                        result.success("API Key Set!")
                    } else {
                        result.error("ERROR", "API Key not found", null)
                    }
                } else {
                    result.notImplemented()
                }
            }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val alertChannelId = "driver_alert_channel"
            val alertChannelName = "Driver Alerts"
            val soundFile = "driver_alert_sound"
            val currentPackage = applicationContext.packageName

            val soundUri = Uri.parse("android.resource://$currentPackage/raw/$soundFile")
            val attributes = AudioAttributes.Builder()
                .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                .build()

            val alertChannel = NotificationChannel(
                alertChannelId,
                alertChannelName,
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                setSound(soundUri, attributes)
                enableVibration(true)
                description = "Alerts for driver notifications"
            }

            val notificationManager =
                getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(alertChannel)
        }
    }

    private fun storeApiKey(apiKey: String) {
        val sharedPreferences = getSharedPreferences("app_prefs", MODE_PRIVATE)
        sharedPreferences.edit().putString("MAPS_API_KEY", apiKey).apply()
    }

    private fun setApiKeyInManifest(apiKey: String) {
        try {
            val appInfo: ApplicationInfo =
                packageManager.getApplicationInfo(packageName, PackageManager.GET_META_DATA)
            appInfo.metaData.putString("com.google.android.geo.API_KEY", apiKey)
        } catch (e: PackageManager.NameNotFoundException) {
            e.printStackTrace()
        }
    }
}
