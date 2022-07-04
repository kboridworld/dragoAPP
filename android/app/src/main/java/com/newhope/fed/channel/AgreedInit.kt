package com.newhope.fed.channel

import android.content.Context
import androidx.annotation.Keep
import io.flutter.plugin.common.MethodChannel

/**
 * 用户点击同意隐私协议之后的初始化动作
 */
@Keep
class AgreedInit constructor(private val ctx: Context, private val result: MethodChannel.Result) {
    fun agreedInit() {
    }
}
