//
//  SearchService.swift
//  Nasa
//
//  Created by саргашкаева on 29.06.2023.
//

import Foundation


protocol SearchService {
    func performFetchRequest(with query: String) async throws -> SearchResult 
}


class SearchServiceImpl: SearchService {
    static let shared = SearchServiceImpl()
    private init() { }
    func performFetchRequest(with query: String) async throws -> SearchResult {
            let results = try await APIServiceImpl.shared.performFetching(endpoint: SearchRouter.search(q: query), type: SearchResult.self)
            return results
    }
}
