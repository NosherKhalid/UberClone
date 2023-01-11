//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Nosher Khalid on 1/3/23.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var startLocationText = ""
    @State private var endLocationText = ""
    @StateObject private var viewModel = LocationSearchViewModel()
    
    var body: some View {
        //Header View
        VStack {
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray2))
                        .frame(width: 1, height: 50)
                    Rectangle()
                        .fill(Color(.black))
                        .frame(width: 6, height: 6)
                }
                
                VStack {
                    TextField("Current location", text: $startLocationText)
                        .frame(height: 35)
                        .background(Color(.lightGray))
                    TextField("Where to?", text: $viewModel.queryFragment)
                        .frame(height: 35)
                        .background(Color(.systemGray))
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            //Divider
            Divider()
                .padding(.vertical)
            
            // List View
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.searchList, id: \.self) { item  in
                    LocationSearchResultCell(title: item.title, subtitle: item.subtitle)
                }
            }
        }
        .padding(.top, 72)
        .background(Color.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
