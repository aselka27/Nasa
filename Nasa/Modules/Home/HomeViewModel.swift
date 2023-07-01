//
//  HomeViewModel.swift
//  Nasa
//
//  Created by саргашкаева on 29.06.2023.
//

import Foundation
import Combine


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
                } else {
                    // start search
                    print(query)
                    self?.performSearch(with: query)
                }
            }
            .store(in: &searchCancellable)
    }
    
    func performSearch(with query: String) {
        guard !query.isEmpty else { return }
        Task { @MainActor in
            do {
                viewState = .loading
                let response =  try await searchService.performFetchRequest(with: query)
                guard let items = response.collection?.items else { return }
                searchResult = items
                viewState = .success(items)
               
            } catch {
                viewState = .error(error)
                print(error)
            }
        }
    }
}
