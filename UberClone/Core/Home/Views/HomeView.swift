//
//  HomeView.swift
//  UberClone
//
//  Created by Nosher Khalid on 1/1/23.
//

import SwiftUI

struct HomeView: View {
    @State var shouldShowLocationSearchView = false
    
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewRepresentable()
                .ignoresSafeArea()
            if shouldShowLocationSearchView {
                LocationSearchView()
            } else {
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        shouldShowLocationSearchView.toggle()
                    }
            }
            MapViewActionButton(shouldShowLocationView: $shouldShowLocationSearchView)
                .padding(.leading)
                .padding(.top, 4)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
