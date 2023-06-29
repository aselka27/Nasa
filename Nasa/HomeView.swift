//
//  ContentView.swift
//  Nasa
//
//  Created by саргашкаева on 28.06.2023.
//

import SwiftUI

struct HomeView: View {
    @State var query: String = ""
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Text("Nasa Search Engine")
                        .font(.custom("OpenSans-Bold", size: 34))
                        .foregroundColor(Color("orange"))
                }
                SearchBar(searchText: $query)
                SearchResultView()
                SearchResultView()
                SearchResultView()
                SearchResultView()
                SearchResultView()
                SearchResultView()
            }
            .background(LinearGradient(colors: [Color("background"), Color("orange")], startPoint: .top, endPoint: .bottom))
          
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
