//
//  HomeViewModel.swift
//  Nasa
//
//  Created by саргашкаева on 29.06.2023.
//

import Combine
import SwiftUI

@MainActor
protocol HomeViewModel: ObservableObject {
    var searchQuery: String { get set }
    var viewState: ViewState<[Item]>? { get set }
    var searchService: SearchService { get set }
    func getSearchResult()
    var searchResult: [Item] { get }
    init(service: SearchService)
}


@MainActor
class HomeViewModelImpl: HomeViewModel {
    
    @Published var searchQuery: String = ""
    @Published var viewState: ViewState<[Item]>?
    var searchCancellable: Set<AnyCancellable> = []
    var searchService: SearchService
    @Published var searchResult: [Item] = []
    var isRequestInProgress = false
    var currentPage = 1
    var pageSize: Int { 100 }
    var totalHits: Int = 0
    
    required init(service: SearchService) {
        viewState = .none
        self.searchService = service
        getSearchResult()
    }
    func getSearchResult() {
        $searchQuery
            .debounce(for: .seconds(0.6), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                if query == "" {
                    // data is reset
                    self?.searchResult = []
                    self?.currentPage = 1
                    self?.viewState = .none
                } else {
                    // start search
                    self?.performSearch(with: query)
                }
            }
            .store(in: &searchCancellable)
    }
    
    func performSearch(with query: String) {
        guard !query.isEmpty  else { return }
        Task {
            do {
                viewState = .loading
                let response =  try await searchService.performFetchRequest(with: query, page: currentPage, pageSize: pageSize)
                guard let items = response.collection?.items else { return }
                totalHits = (response.collection?.metadata.totalHits)!
                searchResult.append(contentsOf: items)
                viewState = .success(searchResult)
               
            } catch {
                viewState = .error(error)
             
            }
        }
    }
    func loadNextPageIfNeeded(items: [Item]) async {
        let lastIndex = items.count
        if totalHits >= lastIndex && !isRequestInProgress { // Check if a request is already in progress
            isRequestInProgress = true // Set the flag to indicate a request is being made
            currentPage += 1
            Task {
                do {
                    let response = try await searchService.performFetchRequest(with: searchQuery, page: currentPage, pageSize: pageSize)
                    guard let items = response.collection?.items else {
                        return
                    }
                    searchResult.append(contentsOf: items)
                    viewState = .success(searchResult)
           
                } catch {
                    viewState = .error(error)
                }
                isRequestInProgress = false // Reset the flag after the request is completed
            }
        }
    }
    
    func canTriggerPagination(for item: Item) -> Bool {
        return searchResult.count > 0 &&
        searchResult.last == item ? true : false
    }
}
