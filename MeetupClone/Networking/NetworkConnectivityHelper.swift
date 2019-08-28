//
//  NetworkConnectivityHelper.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/28/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation
import SystemConfiguration

class NetworkConnectivityHelper {
    
    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com")
    
    private(set) var isReachable: Bool = true
    
    init() {
        checkForReachability()
    }
    
    private func checkForReachability() {
        var flags = SCNetworkReachabilityFlags()
        if let reachability = self.reachability {
            SCNetworkReachabilityGetFlags(reachability, &flags)
            isReachable = isNetworkReachable(flags: flags)
        }
    }
    
    private func isNetworkReachable(flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
}
