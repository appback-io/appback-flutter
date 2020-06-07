package io.appback.app_back.device

import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.content.res.Configuration
import android.os.Build
import android.provider.Settings
import io.flutter.plugin.common.MethodChannel.Result

internal object DeviceUtils {

    fun invokeApplicationVersion(applicationContext: Context, result: Result) {
        val applicationVersion = getApplicationVersion(applicationContext)
        if (applicationVersion.isNullOrBlank()) result.error("UNAVAILABLE", "Application version not available.", null)
        else result.success(applicationVersion)
    }

    fun invokeDeviceID(applicationContext: Context, result: Result) {
        val deviceID = getDeviceID(applicationContext)
        if (deviceID.isEmpty()) result.error("UNAVAILABLE", "Device ID not available.", null)
        else result.success(deviceID)
    }

    fun invokeDeviceName(result: Result) {
        val deviceName = getDeviceName()
        if (deviceName.isEmpty()) result.error("UNAVAILABLE", "Device name not available.", null)
        else result.success(deviceName)
    }

    fun invokeDeviceOrientation(applicationContext: Context, result: Result) {
        val deviceOrientation = getDeviceOrientation(applicationContext)
        if (deviceOrientation.isEmpty()) result.error("UNAVAILABLE", "Device orientation not available.", null)
        else result.success(deviceOrientation)
    }

    fun invokeDeviceVersion(result: Result) {
        val deviceVersion = getOSVersion()
        if (deviceVersion.isEmpty()) result.error("UNAVAILABLE", "Device version not available.", null)
        else result.success(deviceVersion)
    }

    private fun getApplicationVersion(applicationContext: Context): String? {
        return try {
            val packageInfo = applicationContext.packageManager.getPackageInfo(applicationContext.packageName, 0)
            packageInfo.versionName
        } catch (exception: PackageManager.NameNotFoundException) {
            null
        }
    }

    @SuppressLint("HardwareIds")
    private fun getDeviceID(applicationContext: Context): String = Settings.Secure.getString(applicationContext.contentResolver, Settings.Secure.ANDROID_ID)

    private fun getDeviceName(): String = "${Build.MANUFACTURER} ${Build.MODEL}"

    private fun getDeviceOrientation(context: Context): String {
        return when(context.resources.configuration.orientation) {
            Configuration.ORIENTATION_PORTRAIT -> "Portrait"
            Configuration.ORIENTATION_LANDSCAPE -> "Landscape"
            else -> "Undefined"
        }
    }

    private fun getOSVersion(): String = Build.VERSION.RELEASE
}