//
//  ContentView.swift
//  Nasa
//
//  Created by саргашкаева on 28.06.2023.
//

import SwiftUI
import Combine

struct HomeView: View {
    @StateObject var viewModel = HomeViewModelImpl()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                Text("Nasa Search Engine")
                    .font(.custom(AppFonts.openSansBold, size: 22))
                    .foregroundColor(.white)
                SearchBar(searchText: $viewModel.searchQuery)
                    switch viewModel.viewState {
                    case .loading:
                         ProgressView()
                    case .success(let items):
                            ForEach(items, id: \.data?.first?.id) { item in
                                NavigationLink {
                                    SearchResultDetailView(item: item)
                                } label: {
                                    SearchResultView(item: item)
                                }
                            }
                        
                    case .error(let description):
                        EmptyView()
                    }
            }
            .padding(.top, 70)
        }
        .edgesIgnoringSafeArea(.top)
        .background(LinearGradient(colors: [Color("gradient1"), Color("gradient2")], startPoint: .top, endPoint: .bottom))
        .navigationBarHidden(true)
        .onTapGesture {
            self.hideKeyboard1()
        }
       
        
    }
    
 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
extension View {
    func hideKeyboard1() {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
    }
}

