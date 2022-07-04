package com.android.dragoma

import android.content.Intent
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    private val tag = "YlzConsignor"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.i(tag, "MainActivity onCreate--->")
    }


    override fun onFlutterUiDisplayed() {
        super.onFlutterUiDisplayed()
        trackCall()
    }

    //已启动重新进入
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        Log.i(tag, "MainActivity onNewIntent--->")
        trackCall()
    }

    private fun trackCall() {
    }
}
