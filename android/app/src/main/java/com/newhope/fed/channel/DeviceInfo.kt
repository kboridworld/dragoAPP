package com.newhope.fed.channel

import android.content.Context
import androidx.annotation.Keep
import com.android.dragoma.utils.DeviceUtil
import io.flutter.plugin.common.MethodChannel

@Keep
class DeviceInfo constructor(private val ctx: Context, private val result: MethodChannel.Result) {

    fun getDeviceId() {
        result.success(DeviceUtil.getLocalDeviceId(ctx))
    }
}
