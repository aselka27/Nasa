//
//  HomeViewModel.swift
//  Nasa
//
//  Created by саргашкаева on 29.06.2023.
//

import Foundation
import Combine
import SwiftUI


protocol HomeViewModel {
    var searchQuery: String { get set }
    func getSearchResult(_ query: String)
}


class HomeViewModelImpl: HomeViewModel, ObservableObject {
    @Published var searchQuery: String = ""
    @Published var viewState: ViewState<[Item]>?
    var searchCancellable: Set<AnyCancellable> = []
    let searchService = SearchServiceImpl.shared
    @Published var searchResult: [Item] = []
    var isLoading = false
    var currentPage = 1
    var pageSize = 100
    
    init() {
        getSearchResult(searchQuery)
    }
    func getSearchResult(_ query: String) {
        $searchQuery
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                if query == "" {
                    // data is reset
                    self?.viewState = .success([])
                    self?.searchResult = []
                    self?.currentPage = 1
                } else {
                    // start search
                    print(query)
                    self?.performSearch(with: query)
                }
            }
            .store(in: &searchCancellable)
    }
    
    func performSearch(with query: String) {
        guard !query.isEmpty && !isLoading else { return }
        isLoading = true
        Task { @MainActor in
            do {
                viewState = .loading
               
                let response =  try await searchService.performFetchRequest(with: query, page: currentPage, pageSize: pageSize)
                guard let items = response.collection?.items else { return }
                searchResult.append(contentsOf: items)
                viewState = .success(searchResult)
                isLoading = false
                searchResult.forEach { item in
                    print(item.id)
                }
            } catch {
                viewState = .error(error)
                print(error)
            }
        }
    }
    func loadNextPageIfNeeded(items: [Item]) {
          let lastIndex = items.count - 1 //  99
          if lastIndex >= currentPage * pageSize - 1 {
              currentPage += 1
      
              performSearch(with: searchQuery)
          }
      }
}
