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
    }
    
    /// The header's View Model
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                assertionFailure("could not initilize viewModel")
                return
            }
            eventNameLabel.text = viewModel.eventName
            eventLocationLabel.text = viewModel.eventLocation
            createAndAddMapAnnotation()
        }
    }
    
    @IBOutlet private weak var eventLocationMapView: MKMapView!
    
    @IBOutlet private weak var eventNameLabel: UILabel!
    
    @IBOutlet private weak var eventLocationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventLocationMapView.delegate = self
    }
    
    private func createAndAddMapAnnotation() {
        guard let viewModel = viewModel else {
            assertionFailure("could not initilize viewModel")
            return
        }
        if let lattitude = viewModel.eventCoordinates?.latitude,
            let longitude = viewModel.eventCoordinates?.longitude {
            guard eventLocationMapView.annotations.isEmpty else {
                eventLocationMapView.removeAnnotations(eventLocationMapView.annotations)
                return
            }
            let locationAnnotation = MKPointAnnotation()
            locationAnnotation.coordinate = CLLocationCoordinate2D(latitude: lattitude, longitude: longitude)
            locationAnnotation.title = viewModel.eventName
            eventLocationMapView.addAnnotation(locationAnnotation)
        } else {
            eventLocationMapView.isHidden = true
        }
    }
}

extension EventHeaderView: MKMapViewDelegate {
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil }
        let identifier = "Annotation"
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        eventLocationMapView.showAnnotations([annotation], animated: true)
        return annotationView
    }
}
