import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let appBackChannel = FlutterMethodChannel(name: GeneralConstants.kPlatformChannel, binaryMessenger: controller.binaryMessenger)
    appBackChannel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        switch call.method {
        case GeneralConstants.kGetBatteryLevel:
            DeviceUtils.invokeBatteryLevel(result: result)
        case GeneralConstants.kGetApplicationVersion:
            DeviceUtils.invokeApplicationVersion(result: result)
        case GeneralConstants.kGetDeviceID:
            DeviceUtils.invokeDeviceID(result: result)
        case GeneralConstants.kGetDeviceName:
            DeviceUtils.invokeDeviceName(result: result)
        case GeneralConstants.kGetDeviceOrientation:
            DeviceUtils.invokeDeviceOrientation(result: result)
        case GeneralConstants.kGetAvailableStorage:
            DeviceUtils.invokeAvailableStorage(result: result)
        case GeneralConstants.kGetTotalStorage:
            DeviceUtils.invokeTotalStorage(result: result)
        case GeneralConstants.kGetOSVersion:
            DeviceUtils.invokeOSVersion(result: result)
        case GeneralConstants.kGetCarrierName:
            ConnectivityUtils.invokeCarrierName(result: result)
        case GeneralConstants.kGetConnectionType:
            ConnectivityUtils.invokeConnectionType(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
