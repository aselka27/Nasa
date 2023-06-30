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
                        .foregroundColor(.white)
                }
                SearchBar(searchText: $viewModel.searchQuery)
                switch viewModel.viewState {
                case .loading:
                    ProgressView()
                        .padding(.top)
                case .success(let searchResult):
                    ForEach(searchResult, id: \.id) { item in
                        SearchResultView(item: item)
                    }
                case .error(let errorDescription):
                    ErrorView()
                }
                Spacer()
            }
            .padding(.top, 50)
        }
        .background(LinearGradient(colors: [Color("background"), Color("orange")], startPoint: .leading, endPoint: .trailing))
        
        .frame(height: UIScreen.main.bounds.height)
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


//                switch viewModel.viewState {
//                case .loading:
//                    ProgressView()
//                        .padding(.top)
//                case .success(let searchResult):
//                    ForEach(searchResult, id: \.id) { item in
//                        SearchResultView(item: item)
//                    }
//                case .error(let errorDescription):
//                    ErrorView()
//                }
