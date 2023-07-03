//
//  ContentView.swift
//  Nasa
//
//  Created by саргашкаева on 28.06.2023.
//

import SwiftUI
import Combine

struct HomeView: View {
    @StateObject var viewModel: HomeViewModelImpl
    @State private var scrollOffset: CGFloat = 0
    private let scrollThreshold: CGFloat = 100

    init(dataService: SearchService) {
        _viewModel = StateObject(wrappedValue: HomeViewModelImpl(service: dataService))
    }
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(R.color.gradient1()!), Color(R.color.gradient2()!)], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            ScrollView(.vertical) {
                        LazyVStack {
                            Text(StringConstants.homeViewTitle)
                                .font(.custom(AppFonts.openSansBold, size: 22))
                                .foregroundColor(.white)
                            SearchBar(searchText: $viewModel.searchQuery)
                                switch viewModel.viewState {
                                case .loading:
                                     Text("Loading...")
                                        .foregroundColor(.white)
                                case .success(let items):
                                    if items.count == 0 {
                                        Spacer(minLength: 200)
                                        noResults()
                                    }
                                    ForEach(items) { item in
                                            NavigationLink {
                                                SearchResultDetailView(item: item)
                                            } label: {
                                                SearchResultView(item: item)
                                            }
                                            .task {
                                                if viewModel.canTriggerPagination(for: item) {
                                                  await  viewModel.loadNextPageIfNeeded(items: items)
                                                }
                                            }
                                        }
                                    
                                case .error(_):
                                    Spacer(minLength: 200)
                                    ErrorView()
                                case .none:
                                    Spacer(minLength: 200)
                                  StartSearchView()
                                }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)
                }
                .navigationBarHidden(true)
                .onAppear {
                    UIScrollView.appearance().keyboardDismissMode = .onDrag
                }
                .onTapGesture {
                    dismissKeyboard()
            }
        }
        
    }
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
 
   
}


extension HomeView {
    func noResults() -> some View {
        Text("No Results")
    }
}

