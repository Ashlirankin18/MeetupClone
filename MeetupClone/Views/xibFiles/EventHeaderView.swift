//
//  EventHeaderView.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/8/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit
import MapKit

protocol EventHeaderViewDelegate: AnyObject {
    func showAnnotationView(mapView: MKMapView, annotation: MKAnnotation)
}
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
    
    weak var eventHeaderViewDelegate: EventHeaderViewDelegate?
    
    /// The header's View Model
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                assertionFailure("could not initilize viewModel")
                return
            }
            eventNameLabel.text = viewModel.eventName
            eventLocationLabel.text = viewModel.eventLocation
            eventLocationMapView.delegate = self
            createAndAddMapAnnotation()
        }
    }
    
    @IBOutlet private weak var eventLocationMapView: MKMapView!
    
    @IBOutlet private weak var eventNameLabel: UILabel!
    
    @IBOutlet private weak var eventLocationLabel: UILabel!
    
    private func createAndAddMapAnnotation() {
        guard let viewModel = viewModel else {
            assertionFailure("could not initilize viewModel")
            return
        }
        if let lattitude = viewModel.eventCoordinates?.latitude,
            let longitude = viewModel.eventCoordinates?.longitude {
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
        
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView.annotation = annotation
            eventHeaderViewDelegate?.showAnnotationView(mapView: eventLocationMapView, annotation: annotation)
            return annotationView
        } else {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            eventHeaderViewDelegate?.showAnnotationView(mapView: eventLocationMapView, annotation: annotation)
            return annotationView
        }
    }
}
