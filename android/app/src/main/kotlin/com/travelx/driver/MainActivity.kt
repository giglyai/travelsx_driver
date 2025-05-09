package com.travelx.driver

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager

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

    private fun storeApiKey(apiKey: String) {
        val sharedPreferences = getSharedPreferences("app_prefs", MODE_PRIVATE)
        sharedPreferences.edit().putString("MAPS_API_KEY", apiKey).apply()
    }
    private fun setApiKeyInManifest(apiKey: String) {
        try {
            val appInfo: ApplicationInfo = packageManager.getApplicationInfo(packageName, PackageManager.GET_META_DATA)
            appInfo.metaData.putString("com.google.android.geo.API_KEY", apiKey)
        } catch (e: PackageManager.NameNotFoundException) {
            e.printStackTrace()
        }
    }
}