//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Nosher Khalid on 1/6/23.
//

import Foundation
import MapKit
import SwiftUI

class LocationSearchViewModel: NSObject, ObservableObject {
    
    @Published var searchList = [MKLocalSearchCompletion]()
    @Published var coordinate: CLLocationCoordinate2D?
    
    var searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
//            debugPrint("Query fragment is: \(queryFragment)")
            self.searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        self.searchCompleter.delegate = self
        self.searchCompleter.queryFragment = queryFragment
    }
    
    func selectLocation(localSearch: MKLocalSearchCompletion){
//        self.selectedLocation = location
        searchLocation(forLocalSearchCompletion: localSearch) { response, error in
            if let error {
                debugPrint("Search Location failed with error \(error.localizedDescription)")
                return
            }
            
            guard let mapItem = response?.mapItems.first else {return}
            self.coordinate =  mapItem.placemark.coordinate
            debugPrint("Location Coordinate: \(String(describing: self.coordinate))")
        }
    }
    
    func searchLocation(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchList = completer.results
    }
}
