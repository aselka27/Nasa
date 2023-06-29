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
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(.white)
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
