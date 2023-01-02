//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by Nosher Khalid on 1/2/23.
//

import SwiftUI

struct MapViewActionButton: View {
    var body: some View {
        Button {
            //action
        } label: {
            Image(systemName: "line.3.horizontal")
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
        MapViewActionButton()
    }
}
