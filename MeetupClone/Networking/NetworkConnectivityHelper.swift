//
//  NetworkConnectivityHelper.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/28/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation
import Reachability
protocol NetworkConnectivityHelperDelegate: AnyObject {
    func networkIsAvalible()
    func networkIsUnavalible()
}
/// Handles the tasks related to network connectivity
final class NetworkConnectivityHelper {
    
    private var reachability: Reachability?
    
    private(set) var isReachable: Bool = true
    
    weak var delegate: NetworkConnectivityHelperDelegate?
    
    init() {
        reachability = Reachability()
        
        NotificationCenter.default.addObserver(self, selector: #selector(networkDidChange), name: .reachabilityChanged, object: reachability)
        do {
            try reachability?.startNotifier()
        } catch {
            print("could not start reachability notifier!")
        }
    }
    
    @objc func networkDidChange(_ notification: Notification) {
        guard let reachability = notification.object as? Reachability else {
            assertionFailure("Could not cast object a Reachability")
            return
        }
        switch reachability.connection {
        case .none:
            delegate?.networkIsUnavalible()
        case .cellular, .wifi:
            delegate?.networkIsAvalible()
        }
    }
}
