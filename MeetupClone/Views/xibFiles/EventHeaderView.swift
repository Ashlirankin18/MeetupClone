//
//  EventHeaderView.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/8/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit
import MapKit

/// `UIView` subclass which represents a headerView for a MeetupEvent
final class EventHeaderView: UIView {
    
    @IBOutlet private weak var eventLocationMapView: MKMapView!
    
    @IBOutlet private weak var eventNameLabel: UILabel!
    
    @IBOutlet private weak var eventLocationLabel: UILabel!
    
    /// Hold the data and logic needed to populate the `EventHeaderView`
    struct ViewModel {
        
        /// The coordinates of the event
        let eventCoordinates: CLLocationCoordinate2D
        
        /// The name of the event
        let eventName: String
        
        /// The string representation of the event location
        let eventLocation: String?
    }
    
    /// The header's View Model
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                assertionFailure("could not initilize viewModel")
                return
            }
            eventLocationMapView.setCenter(viewModel.eventCoordinates, animated: true)
        }
    }
}
