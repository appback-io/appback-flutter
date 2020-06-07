import 'package:flutter/services.dart';

class PlatformChannelMethods {
    static const _platform = const MethodChannel('appback.io');

    static Future<String> getAppVersion() async {
        String appVersion;
        try {
            appVersion = await _platform.invokeMethod('getApplicationVersion');
        } on PlatformException catch (error) {
            print("Failed to get application version: '${error.message}'");
        }
        return appVersion;
    }

    static Future<String> getBatteryLevel() async {
        String batteryLevel;
        try {
            final int result = await _platform.invokeMethod('getBatteryLevel');
            batteryLevel = '$result %';
        } on PlatformException catch (error) {
            print("Failed to get battery level: '${error.message}'");
        }
        return batteryLevel;
    }

    static Future<String> getCarrierName() async {
        String carrierName;
        try {
            carrierName = await _platform.invokeMethod('getCarrierName');
        } on PlatformException catch (error) {
            print("Failed to get carrier name: '${error.message}'");
        }
        return carrierName;
    }

    static Future<String> getConnectionType() async {
        String connectionType;
        try {
            connectionType = await _platform.invokeMethod('getConnectionType');
        } on PlatformException catch (error) {
            print("Failed to get connection type: '${error.message}'");
        }
        return connectionType;
    }

    static Future<String> getComposedStorage() async {
        String availableStorage = await _getAvailableStorage();
        String totalStorage = await _getTotalStorage();
        if (availableStorage == null || totalStorage == null) {
            return "Device storage not available.";
        }
        return "$availableStorage / $totalStorage";
    }

    static Future<String> getDeviceID() async {
        String deviceID;
        try {
            deviceID = await _platform.invokeMethod('getDeviceID');
        } on PlatformException catch (error) {
            print("Failed to get device ID: '${error.message}'");
        }
        return deviceID;
    }

    static Future<String> getDeviceName() async {
        String deviceName;
        try {
            deviceName = await _platform.invokeMethod('getDeviceName');
        } on PlatformException catch (error) {
            print("Failed to get device name: '${error.message}'");
        }
        return deviceName;
    }

    static Future<String> getDeviceOrientation() async {
        String deviceOrientation;
        try {
            deviceOrientation = await _platform.invokeMethod('getDeviceOrientation');
        } on PlatformException catch (error) {
            print("Failed to get device orientation: '${error.message}'");
        }
        return deviceOrientation;
    }

    static Future<String> getOSVersion() async {
        String deviceVersion;
        try {
            deviceVersion = await _platform.invokeMethod('getOSVersion');
        } on PlatformException catch (error) {
            print("Failed to get device version: '${error.message}'");
        }
        return deviceVersion;
    }

    static Future<String> _getAvailableStorage() async {
        String availableStorage;
        try {
            final num result = await _platform.invokeMethod('getAvailableStorage');
            availableStorage = '$result GB';
        } on PlatformException catch (error) {
            availableStorage = "Failed to get available storage: '${error.message}'";
        }
        return availableStorage;
    }

    static Future<String> _getTotalStorage() async {
        String totalStorage;
        try {
            final num result = await _platform.invokeMethod('getTotalStorage');
            totalStorage = '$result GB';
        } on PlatformException catch (error) {
            totalStorage = "Failed to get total storage: '${error.message}'";
        }
        return totalStorage;
    }
}