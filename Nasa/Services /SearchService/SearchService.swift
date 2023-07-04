//
//  SearchService.swift
//  Nasa
//
//  Created by саргашкаева on 29.06.2023.
//

import Foundation


protocol SearchService {
    func performFetchRequest(with query: String, page: Int) async throws -> NasaResponseDTO
}


class SearchServiceImpl: SearchService {
    
    var service: APIService
    
    init(service: APIService) {
        self.service = service
    }
   
    func performFetchRequest(with query: String, page: Int) async throws -> NasaResponseDTO {
        return try await service.performFetching(endpoint: SearchRouter.search(q: query, page: page), type: NasaResponseDTO.self)
    }
}
