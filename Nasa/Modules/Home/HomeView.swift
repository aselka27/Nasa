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
                    .padding(.top, 70)
                    .frame(maxWidth: .infinity)
                    
            
            }
            .edgesIgnoringSafeArea(.top)
            .background(LinearGradient(colors: [Color(R.color.gradient1()!), Color(R.color.gradient2()!)], startPoint: .top, endPoint: .bottom))
            .navigationBarHidden(true)
            .onAppear {
                UIScrollView.appearance().keyboardDismissMode = .onDrag
            }
            .onTapGesture {
                dismissKeyboard()
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(dataService: .)
//    }
//}




/*
 GeometryReader { reader -> Color in
     let minY = reader.frame(in: .global).minY
     let height = UIScreen.main.bounds.height*0.8
     // when it goes over the height -> trigger update
     if minY < height {
         print(items.count)
        print("reached bottom")
     }

     return Color.clear
 }
 .frame(width: 20, height: 20)

 */

