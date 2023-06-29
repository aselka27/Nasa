//
//  SearchBar.swift
//  Nasa
//
//  Created by саргашкаева on 28.06.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var body: some View {
        HStack {
            TextField("Start searching", text: $searchText)
                .tint(.red)
                .padding(.horizontal)
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(.gray)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
