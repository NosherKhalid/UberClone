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
    @Published var selectedLocation: String?
    
    var searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            debugPrint("Query fragment is: \(queryFragment)")
            self.searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        self.searchCompleter.delegate = self
        self.searchCompleter.queryFragment = queryFragment
    }
    
    func selectLocation(location: String){
        self.selectedLocation = location
        debugPrint("Selected Location is: \(String(describing: self.selectedLocation))")
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchList = completer.results
    }
}
