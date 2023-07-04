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
    
    init(dataService: SearchService) {
        _viewModel = StateObject(wrappedValue: HomeViewModelImpl(service: dataService))
        UIScrollView.appearance().keyboardDismissMode = .onDrag
    }
    var body: some View {
        ZStack {
            backgroundView()
            ScrollView(.vertical) {
                LazyVStack {
                    Text(StringConstants.homeViewTitle)
                        .font(.custom(R.font.openSansBold, size: 22))
                        .foregroundColor(.white)
                    SearchBar(searchText: $viewModel.searchQuery)
                    switch viewModel.viewState {
                    case .loading:
                        ProgressView()
                            .progressViewStyle(.circular)
                            .imageScale(.large)
                            .tint(.white)
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
                                await viewModel.shouldLoadMoreData(item, items)
                            }
                        }
                    case .error(let error):
                        Spacer(minLength: 200)
                        ErrorView(error: error as! APIError)
                    case .none:
                        Spacer(minLength: 200)
                        StartSearchView()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
            }
            .navigationBarHidden(true)
            .onTapGesture {
                withAnimation {
                    dismissKeyboard()
                }
            }
        }
        
    }
}


extension HomeView {
    func noResults() -> some View {
        Text("No Results")
            .font(.custom(R.font.openSansBold, size: 20))
            .foregroundColor(.white)
    }
    
    func backgroundView() -> some View {
        LinearGradient(colors: [Color(R.color.gradient1()!), Color(R.color.gradient2()!)], startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
}

