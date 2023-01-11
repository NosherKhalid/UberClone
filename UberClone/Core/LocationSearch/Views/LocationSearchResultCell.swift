//
//  LocationSearchResultCell.swift
//  UberClone
//
//  Created by Nosher Khalid on 1/4/23.
//

import SwiftUI

struct LocationSearchResultCell: View {
    
    var title: String
    var subtitle: String
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
            VStack (alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.body)
                    .bold()
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(Color(.gray))
            }
            Spacer()
        }
        .onTapGesture {
            
        }
        .padding(.horizontal)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell(shouldShowHomeView: .constant(false), title: "Starbucks Coffee", subtitle: "123 Main St")
    }
}
