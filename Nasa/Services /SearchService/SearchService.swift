//
//  SearchService.swift
//  Nasa
//
//  Created by саргашкаева on 29.06.2023.
//

import Foundation


protocol SearchService {
    func performFetchRequest(with query: String, page: Int, pageSize: Int) async throws -> NasaResponseDTO
}


class SearchServiceImpl: SearchService {
    func performFetchRequest(with query: String, page: Int, pageSize: Int) async throws -> NasaResponseDTO {
           return try await APIServiceImpl.shared.performFetching(endpoint: SearchRouter.search(q: query, page: page, pageSize: pageSize), type: NasaResponseDTO.self)
    }
}
