//
//  ContentView.swift
//  Nasa
//
//  Created by саргашкаева on 28.06.2023.
//

import SwiftUI

struct HomeView: View {
    @State var query: String = ""
    @StateObject var viewModel = HomeViewModelImpl()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Text("Nasa Search Engine")
                        .font(.custom(AppFonts.openSansBold, size: 34))
                        .foregroundColor(Color("orange"))
                }
                SearchBar(searchText: $viewModel.searchQuery)
                switch viewModel.viewState {
                case .loading:
                    ProgressView()
                case .success(let searchResult):
                    ForEach(searchResult, id: \.id) {_ in
                        SearchResultView()
                    }
                case .error(let errorDescription):
                    EmptyView()
                }
            }
            .background(LinearGradient(colors: [Color("background"), Color("orange")], startPoint: .leading, endPoint: .trailing))
          
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
