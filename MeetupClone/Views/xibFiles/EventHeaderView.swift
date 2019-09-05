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
    
    /// Hold the data and logic needed to populate the `EventHeaderView`
    struct ViewModel {
        
        /// The coordinates of the event
        let eventCoordinates: CLLocationCoordinate2D?
        
        /// The name of the event
        let eventName: String
        
        /// The string representation of the event location
        let eventLocation: String?
        
        /// The description of the event 
        let eventDescription: String?
    }
    
    /// The header's View Model
    var viewModel: ViewModel? {
        didSet {
            eventNameLabel.text = viewModel?.eventName
            eventLocationLabel.text = viewModel?.eventLocation
            eventDescriptionTextView.text = viewModel?.eventDescription
            handleMapAnnotations()
        }
    }
    
    @IBOutlet private weak var eventLocationMapView: MKMapView!
    
    @IBOutlet private weak var eventNameLabel: UILabel!
    
    @IBOutlet private weak var eventLocationLabel: UILabel!
    
    @IBOutlet private weak var eventDescriptionTextView: UITextView!
    
    private func handleMapAnnotations() {
        guard let viewModel = viewModel else {
            assertionFailure("could not initilize viewModel")
            return
        }
        eventLocationMapView.isHidden = false
        eventDescriptionTextView.isHidden = false
        if let lattitude = viewModel.eventCoordinates?.latitude,
            let longitude = viewModel.eventCoordinates?.longitude {
            checksForExistingAnnotations(viewModel: viewModel, lattitude: lattitude, longitude: longitude)
        } else {
            eventLocationMapView.isHidden = true
            eventDescriptionTextView.isHidden = true
        }
    }
    
    private func checksForExistingAnnotations(viewModel: ViewModel, lattitude: Double, longitude: Double) {
        if !eventLocationMapView.annotations.isEmpty {
            eventLocationMapView.removeAnnotations(eventLocationMapView.annotations)
        }
        addAndShowAnnotation(viewModel: viewModel, lattitude: lattitude, longitude: lattitude)
    }
    
    private func addAndShowAnnotation(viewModel: ViewModel, lattitude: Double, longitude: Double) {
        let locationAnnotation = MKPointAnnotation()
        locationAnnotation.coordinate = CLLocationCoordinate2D(latitude: lattitude, longitude: longitude)
        locationAnnotation.title = viewModel.eventName
        eventLocationMapView.addAnnotation(locationAnnotation)
        eventLocationMapView.showAnnotations([locationAnnotation], animated: true)
    }
}
