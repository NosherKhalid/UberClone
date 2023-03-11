//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by Nosher Khalid on 1/2/23.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState: MapViewState
    
    var body: some View {
        Button {
            //action
            withAnimation (.spring()) {
                // Write function here to determine action
                buttonActionOnMapState(mapState: mapState)
            }
            
        } label: {
            Image(systemName: imageNameOnMapState(mapState: mapState))
                .font(.title2)
                .padding()
                .foregroundColor(.black)
                .background(Color(.white))
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func buttonActionOnMapState(mapState: MapViewState){
        switch mapState {
        case .noInput:
            debugPrint("No input")
        case .searchingForLocation:
            debugPrint("Show HomeScreen")
            self.mapState = .noInput
        case .locationSelected:
            self.mapState = .noInput
            debugPrint("Remove MapView Items..")
        }
    }
    
    func imageNameOnMapState(mapState: MapViewState) -> String {
        switch mapState {
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation, .locationSelected:
            return "arrow.left"
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noInput))
    }
}
