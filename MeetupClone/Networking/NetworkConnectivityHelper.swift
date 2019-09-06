//
//  NetworkConnectivityHelper.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/28/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation
import Reachability

/// Informs subscribers about network availability.
protocol NetworkConnectivityHelperDelegate: AnyObject {
    func networkIsAvailable()
    func networkIsUnavailable()
}
/// Handles the tasks related to network connectivity
final class NetworkConnectivityHelper {
    
    private let reachability = Reachability()
    
    weak var delegate: NetworkConnectivityHelperDelegate?
    
    init() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(networkDidChange), name: .reachabilityChanged, object: reachability)
        do {
            try reachability?.startNotifier()
        } catch {
            print("could not start reachability notifier!")
        }
    }
    
    @objc private func networkDidChange(_ notification: Notification) {
        guard let reachability = notification.object as? Reachability else {
            assertionFailure("Could not cast object a Reachability")
            return
        }
        switch reachability.connection {
        case .none:
            delegate?.networkIsUnavailable()
        case .cellular, .wifi:
            delegate?.networkIsAvailable()
        }
    }
}
