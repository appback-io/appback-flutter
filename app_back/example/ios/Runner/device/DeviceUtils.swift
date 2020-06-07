//
//  DeviceUtils.swift
//  Runner
//
//  Created by Nicolás David Muñoz Cuervo on 7/06/20.
//

import Foundation

class DeviceUtils {
    
    static func invokeApplicationVersion( result: @escaping FlutterResult) {
        let applicationVersion = getApplicationVersion()
        if applicationVersion.isEmpty {
            result(FlutterError(code: "UNAVAILABLE", message: "Application version unavailable", details: nil))
        } else {
            result(applicationVersion)
        }
    }
    
    static func invokeAvailableStorage(result: @escaping FlutterResult) {
        let availableStorage = getAvailableStorage()
        if availableStorage == nil {
            result(FlutterError(code: "UNAVAILABLE", message: "Available version unavailable", details: nil))
        } else {
            result(availableStorage)
        }
    }
    
    static func invokeBatteryLevel(result: @escaping FlutterResult) {
        let batteryLevel = getBatteryLevel()
        if batteryLevel != nil {
            result(FlutterError(code: "UNAVAILABLE", message: "Battery info unavailable", details: nil))
        } else {
            result(batteryLevel)
        }
    }
    
    static func invokeDeviceID(result: @escaping FlutterResult) {
        let deviceID = getDeviceID()
        if deviceID == nil {
            result(FlutterError(code: "UNAVAILABLE", message: "Device ID unavailable", details: nil))
        } else {
            result(deviceID)
        }
    }
    
    static func invokeDeviceName(result: @escaping FlutterResult) {
        let deviceName = getDeviceName()
        if deviceName.isEmpty {
            result(FlutterError(code: "UNAVAILABLE", message: "Device name unavailable", details: nil))
        } else {
            result(deviceName)
        }
    }
    
    static func invokeDeviceOrientation(result: @escaping FlutterResult) {
        let deviceOrientation = getDeviceOrientation()
        if deviceOrientation.isEmpty {
            result(FlutterError(code: "UNAVAILABLE", message: "Device orientation unavailable", details: nil))
        } else {
            result(deviceOrientation)
        }
    }
    
    static func invokeOSVersion(result: @escaping FlutterResult) {
        let osVersion = getOSVersion()
        if osVersion.isEmpty {
            result(FlutterError(code: "UNAVAILABLE", message: "OS version unavailable", details: nil))
        } else {
            result(osVersion)
        }
    }
    
    static func invokeTotalStorage(result: @escaping FlutterResult) {
        let totalStorage = getTotalStorage()
        if totalStorage == nil {
            result(FlutterError(code: "UNAVAILABLE", message: "Total version unavailable", details: nil))
        } else {
            result(totalStorage)
        }
    }
    
    private static func getApplicationVersion() -> String {
        let dictionary = Bundle.main.infoDictionary
        let version = dictionary?["CFBundleShortVersionString"] as? String ?? ""
        return version
    }
    
    private static func getAvailableStorage() -> String? {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let availableStorage = (systemAttributes[.systemFreeSize] as? NSNumber)?.int64Value else {
                return nil
        }
        return ByteCountFormatter().string(fromByteCount: availableStorage)
    }
    
    private static func getBatteryLevel() -> Int? {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        if device.batteryState == UIDevice.BatteryState.unknown {
            return nil
        } else {
            return Int(device.batteryLevel * 100)
        }
    }
    
    private static func getDeviceID() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    private static func getDeviceName() -> String {
        return UIDevice().type.rawValue
    }
    
    private static func getDeviceOrientation() -> String {
        return UIApplication.shared.statusBarOrientation.isLandscape ? "Landscape" : "Portrait"
    }
    
    private static func getOSVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    private static func getTotalStorage() -> String? {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let totalStorage = (systemAttributes[.systemSize] as? NSNumber)?.int64Value else {
                return nil
        }
        return ByteCountFormatter().string(fromByteCount: totalStorage)
    }
}
