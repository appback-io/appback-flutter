import 'package:appback_sdk/src/helpers/platform_channel_methods.dart';

class EventLogMapper {
  static Future<Map<String, dynamic>> mapParameters(
      String eventName,
      String router,
      Map<String, String> parameters,
      bool deviceInformation) async {
    List<Map<String, String>> mappedParameters = [];
    parameters.forEach((key, value) {
      mappedParameters.add({key: value});
    });
    if (deviceInformation) {
      String systemVersion = await PlatformChannelMethods.getOSVersion();
      String appVersion = await PlatformChannelMethods.getAppVersion();
      String deviceName = await PlatformChannelMethods.getDeviceName();
      String orientation = await PlatformChannelMethods.getDeviceOrientation();
      String composedStorage =
          await PlatformChannelMethods.getComposedStorage();
      String deviceID = await PlatformChannelMethods.getDeviceID();
      String batteryLevel = await PlatformChannelMethods.getBatteryLevel();
      String carrierName = await PlatformChannelMethods.getCarrierName();
      String connectionType = await PlatformChannelMethods.getConnectionType();
      mappedParameters.add({"_system_version": systemVersion});
      mappedParameters.add({"_app_version": appVersion});
      mappedParameters.add({"_device": deviceName});
      mappedParameters.add({"orientation": orientation});
      mappedParameters.add({"storage": composedStorage});
      mappedParameters.add({"_device_ID": deviceID});
      mappedParameters.add({"_battery_level": batteryLevel});
      mappedParameters.add({"_carrier": carrierName});
      mappedParameters.add({"_connection_type": connectionType});
    }
    return {
      "router": router,
      "name": eventName,
      "time": DateTime.now().millisecondsSinceEpoch ~/ 1000,
      "parameters": mappedParameters
    };
  }
}
