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
                         Text("Loading...")
                            .foregroundColor(.white)
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
                    case .none:
                        EmptyView()
                    }
            }
            .padding(.top, 70)
        }
        .edgesIgnoringSafeArea(.top)
        .background(LinearGradient(colors: [Color("gradient1"), Color("gradient2")], startPoint: .top, endPoint: .bottom))
        .navigationBarHidden(true)
        .onAppear {
            UIScrollView.appearance().keyboardDismissMode = .interactive
        }
        .onTapGesture {
            dismissKeyboard()
        }
       
    }
    func dismissKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

