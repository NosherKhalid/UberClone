//
//  UberMapViewRepresentable.swift
//  UberClone
//
//  Created by Nosher Khalid on 1/1/23.
//

import Foundation
import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    
    //MARK: - Properties and Instances
    @EnvironmentObject var viewModel: LocationSearchViewModel
    private let mapView = MKMapView()
    let locationManager = LocationManager()
    
    // MARK: - Methods
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.userTrackingMode = .follow
        mapView.showsUserLocation = true
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate = viewModel.coordinate {
            context.coordinator.selectAndAddAnnotation(forCoordinate: coordinate)
            context.coordinator.generatePolyline(withDestination: coordinate)
            debugPrint("Selected Location Coordinate on Map is: \(String(describing: coordinate))")
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension UberMapViewRepresentable {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        //MARK: - Properties
        let parent: UberMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        
        //MARK: - Lifecycle
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        //MARK: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .black
            polyline.lineWidth = 8
            return polyline
        }
        
        //MARK: - Helpers
        
        func selectAndAddAnnotation(forCoordinate coordinate: CLLocationCoordinate2D){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            parent.mapView.addAnnotation(annotation)
            parent.mapView.selectAnnotation(annotation, animated: true)
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        func generatePolyline(withDestination destlocation: CLLocationCoordinate2D){
            getDestinationRoute(from: userLocationCoordinate!, to: destlocation) { route in
                self.parent.mapView.addOverlay(route.polyline)
            }
        }
        
        func getDestinationRoute(from: CLLocationCoordinate2D,
                                 to: CLLocationCoordinate2D,
                                 completion: @escaping (MKRoute) -> Void){
            let startLocation = MKPlacemark(coordinate: from)
            let destinationLocation = MKPlacemark(coordinate: to)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: startLocation)
            request.destination = MKMapItem(placemark: destinationLocation)
            let direction = MKDirections(request: request)
            direction.calculate { response, error in
                if let error {
                    debugPrint("Error in generating route \(error.localizedDescription)")
                } else {
                    guard let route = response?.routes.first else {return}
                    completion(route)
                }
            }
        }
    }
}
