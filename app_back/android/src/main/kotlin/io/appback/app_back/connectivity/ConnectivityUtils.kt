package io.appback.app_back.connectivity

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build
import android.telephony.TelephonyManager
import io.flutter.plugin.common.MethodChannel.Result

internal object ConnectivityUtils {

    fun invokeCarrierName(applicationContext: Context, result: Result) {
        val deviceName = getCarrierName(applicationContext)
        if (deviceName.isNullOrBlank()) result.error("UNAVAILABLE", "Carrier name not available.", null)
        else result.success(deviceName)
    }

    fun invokeConnectionType(applicationContext: Context, result: Result) {
        val connectionType = getConnectionType(applicationContext)
        if (connectionType.isNullOrBlank()) result.error("UNAVAILABLE", "Connection type not available.", null)
        else result.success(connectionType)
    }

    private fun getCarrierName(applicationContext: Context): String? {
        val manager = applicationContext.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager
        return manager?.networkOperatorName
    }

    @Suppress("DEPRECATION")
    private fun getConnectionType(applicationContext: Context): String? {
        val manager = applicationContext.getSystemService(Context.CONNECTIVITY_SERVICE) as? ConnectivityManager
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val networkCapabilities = manager?.activeNetwork
            val activeNetworkInfo = manager?.getNetworkCapabilities(networkCapabilities)
            when {
                activeNetworkInfo?.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) == true -> "WIFI"
                activeNetworkInfo?.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) == true -> "CELLULAR"
                activeNetworkInfo?.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) == true -> "ETHERNET"
                else -> "Undefined"
            }
        } else {
            manager?.run {
                activeNetworkInfo?.run {
                    when (type) {
                        ConnectivityManager.TYPE_WIFI -> "WIFI"
                        ConnectivityManager.TYPE_MOBILE -> "CELLULAR"
                        ConnectivityManager.TYPE_ETHERNET -> "ETHERNET"
                        else -> "Undefined"
                    }
                }
            }
        }
    }
}