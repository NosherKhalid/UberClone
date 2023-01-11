//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Nosher Khalid on 1/1/23.
//

import SwiftUI

@main
struct UberCloneApp: App {
    
    @StateObject private var locationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
