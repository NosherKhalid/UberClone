//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by Nosher Khalid on 1/2/23.
//

import SwiftUI

struct MapViewActionButton: View {
    
    @Binding var shouldShowLocationView: Bool
    
    var body: some View {
        Button {
            //action
            withAnimation (.spring()) {
                shouldShowLocationView.toggle()
            }
            
        } label: {
            Image(systemName: shouldShowLocationView ? "arrow.left" : "line.3.horizontal")
                .font(.title2)
                .padding()
                .foregroundColor(.black)
                .background(Color(.white))
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(shouldShowLocationView: .constant(false))
    }
}
