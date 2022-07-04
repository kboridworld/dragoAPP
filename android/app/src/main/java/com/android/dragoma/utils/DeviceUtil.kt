package com.android.dragoma.utils

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import android.text.TextUtils
import androidx.core.app.ActivityCompat
import androidx.core.content.edit
import com.android.dragoma.PRJApplication
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException
import java.util.*


private const val DEVICE_LOCAL_ID = "DEVICE_LOCAL_ID"
private const val DEVICE_LOCAL_UUID = "DEVICE_LOCAL_UUID"

object DeviceUtil {
    fun getLocalDeviceId(context: Context): String {
        val prefFile = "${context.packageName}.$DEVICE_LOCAL_ID"
        val preferences = context.getSharedPreferences(prefFile, Context.MODE_PRIVATE)
        var uuid = preferences.getString(DEVICE_LOCAL_UUID, null)
        if (TextUtils.isEmpty(uuid)) {
            uuid = getUniqueId(context)
            preferences.edit {
                putString(DEVICE_LOCAL_UUID, uuid).apply()
            }
        }
        return uuid!!

    }

    /**
     * 获取设备唯一 ID
     * @param context 上下文
     * @return 设备唯一 ID
     */
    private fun getUniqueId(context: Context): String {
        // 不选用需要权限的获取 ID 方式
        val data = getAndroidId(context) + getSerialNumber(context) + uniquePseudosId
        return encode(data).toUpperCase(Locale.CHINA)
    }

    /**
     * 获取 Android ID
     * @param context 上下文
     * @return androidId
     */
    private fun getAndroidId(context: Context): String =
        Settings.System.getString(context.contentResolver, Settings.System.ANDROID_ID)

    /**
     * 获取序列号
     * @return 序列号
     */
    private fun getSerialNumber(context: Context): String {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O && ActivityCompat.checkSelfPermission(
                    context,
                    Manifest.permission.READ_PHONE_STATE
                ) == PackageManager.PERMISSION_GRANTED
            ) Build.getSerial() else Build.SERIAL
        } catch (e: Exception) {
            "serial"
        }
    }

    /**
     * 伪 IMEI
     * @return 伪 IMEI
     */
    private val uniquePseudosId: String
        get() =
            "35" +
                    Build.BOARD.length % 10 +
                    Build.BRAND.length % 10 +
                    Build.CPU_ABI.length % 10 +
                    Build.DEVICE.length % 10 +
                    Build.DISPLAY.length % 10 +
                    Build.HOST.length % 10 +
                    Build.ID.length % 10 +
                    Build.MANUFACTURER.length % 10 +
                    Build.MODEL.length % 10 +
                    Build.PRODUCT.length % 10 +
                    Build.TAGS.length % 10 +
                    Build.TYPE.length % 10 +
                    Build.HARDWARE.length % 10 //13 digits


    private fun encode(text: String): String {
        try {
            //获取md5加密对象
            val instance: MessageDigest = MessageDigest.getInstance("MD5")
            //对字符串加密，返回字节数组
            val digest: ByteArray = instance.digest(text.toByteArray())
            val sb = StringBuffer()
            for (b in digest) {
                //获取低八位有效值
                var i: Int = b.toInt() and 0xff
                //将整数转化为16进制
                var hexString = Integer.toHexString(i)
                if (hexString.length < 2) {
                    //如果是一位的话，补0
                    hexString = "0$hexString"
                }
                sb.append(hexString)
            }
            return sb.toString()

        } catch (e: NoSuchAlgorithmException) {
            e.printStackTrace()
        }
        return ""
    }


    val currentAppVersion: String?
        get() = PRJApplication.instance.packageManager
            .getPackageInfo(PRJApplication.instance.packageName, 0)
            ?.run {
                versionName;
            }

    val currentAppChannel: String?
        get() {
            val applicationInfo = PRJApplication.instance.packageManager.getApplicationInfo(PRJApplication.instance.packageName, PackageManager.GET_META_DATA)
            return applicationInfo.metaData.getString("UMENG_CHANNEL", "official")
        }
}
