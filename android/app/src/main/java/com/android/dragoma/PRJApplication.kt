package com.android.dragoma

import android.content.Context
import androidx.multidex.MultiDex
import io.flutter.app.FlutterApplication
import kotlin.properties.Delegates


class PRJApplication : FlutterApplication() {

    companion object {
        var instance: PRJApplication by Delegates.notNull()
    }

    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        MultiDex.install(base)
        instance = this
    }
}
