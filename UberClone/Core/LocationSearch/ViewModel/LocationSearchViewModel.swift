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
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchList = completer.results
    }
}
