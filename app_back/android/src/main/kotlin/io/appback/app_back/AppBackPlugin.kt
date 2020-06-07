package io.appback.app_back

import android.content.Context
import io.appback.app_back.battery.BatteryUtils
import io.appback.app_back.device.DeviceUtils
import io.appback.app_back.storage.StorageUtils
import io.appback.app_back.connectivity.ConnectivityUtils
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class AppBackPlugin: FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel : MethodChannel
    private lateinit var applicationContext: Context

    private fun onAttachedToEngine(applicationContext: Context, messenger: BinaryMessenger) {
        this.applicationContext = applicationContext
        channel = MethodChannel(messenger, GeneralConstants.kPLATFORM_CHANNEL)
        channel.setMethodCallHandler(this)
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        onAttachedToEngine(flutterPluginBinding.applicationContext, flutterPluginBinding.binaryMessenger)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when(call.method) {
            GeneralConstants.kGET_BATTERY_LEVEL -> BatteryUtils.invokeBatteryLevel(applicationContext, result)
            GeneralConstants.kGET_DEVICE_VERSION -> DeviceUtils.invokeDeviceVersion(result)
            GeneralConstants.kGET_AVAILABLE_STORAGE -> StorageUtils.invokeAvailableStorage(result)
            GeneralConstants.kGET_TOTAL_STORAGE -> StorageUtils.invokeTotalStorage(result)
            GeneralConstants.kGET_DEVICE_NAME -> DeviceUtils.invokeDeviceName(result)
            GeneralConstants.kGET_DEVICE_ORIENTATION -> DeviceUtils.invokeDeviceOrientation(applicationContext, result)
            GeneralConstants.kGET_CARRIER_NAME -> ConnectivityUtils.invokeCarrierName(applicationContext, result)
            GeneralConstants.kGET_CONNECTION_TYPE -> ConnectivityUtils.invokeConnectionType(applicationContext, result)
            GeneralConstants.kGET_APPLICATION_VERSION -> DeviceUtils.invokeApplicationVersion(applicationContext, result)
            GeneralConstants.kGET_DEVICE_ID -> DeviceUtils.invokeDeviceID(applicationContext, result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}