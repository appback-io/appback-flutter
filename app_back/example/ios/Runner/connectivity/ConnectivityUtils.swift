//
//  ConnectivityUtils.swift
//  Runner
//
//  Created by Nicolás David Muñoz Cuervo on 7/06/20.
//

import Foundation
import CoreTelephony
import SystemConfiguration

class ConnectivityUtils {
    static func invokeCarrierName(result: @escaping FlutterResult) {
        let carrierName = getCarrierName()
        if carrierName == nil {
            result(FlutterError(code: "UNAVAILABLE", message: "Carrier name unavailable", details: nil))
        } else {
            result(carrierName)
        }
    }
    
    static func invokeConnectionType(result: @escaping FlutterResult) {
        var connectionType: String? = nil
        if #available(iOS 12.0, *) {
            connectionType = getConnectionType()
        }
        if connectionType == nil {
            result(FlutterError(code: "UNAVAILABLE", message: "Connection type unavailable", details: nil))
        } else {
            result(connectionType)
        }
    }
    
    private static func getCarrierName() -> String? {
        let networkInfo = CTTelephonyNetworkInfo()
        return networkInfo.subscriberCellularProvider?.carrierName
    }
    
    @available(iOS 12.0, *)
    private static func getConnectionType() -> String {
        guard let reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, "www.google.com") else {
            return "NO INTERNET"
        }
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability, &flags)
        
        let isReachable = flags.contains(.reachable)
        let isWWAN = flags.contains(.isWWAN)
        
        if isReachable {
            if isWWAN {
                let networkInfo = CTTelephonyNetworkInfo()
                let carrierType = networkInfo.serviceCurrentRadioAccessTechnology
                guard let carrierTypeName = carrierType?.first?.value else {
                    return "UNKNOWN"
                }
                switch carrierTypeName {
                case CTRadioAccessTechnologyGPRS, CTRadioAccessTechnologyEdge, CTRadioAccessTechnologyCDMA1x:
                    return "2G"
                case CTRadioAccessTechnologyLTE:
                    return "4G"
                default:
                    return "3G"
                }
            } else {
                return "WIFI"
            }
        } else {
            return "NO INTERNET"
        }
    }
}
