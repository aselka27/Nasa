//
//  APIService.swift
//  Nasa
//
//  Created by саргашкаева on 28.06.2023.
//

import Foundation



protocol APIService {
    func performFetching<D: Decodable>(endpoint: BaseRouter, type: D.Type) async throws -> D
}


class APIServiceImpl: APIService {
    static let shared = APIServiceImpl()
    
    private init() {}
    let requestBuilder: URLRequestBuilder = URLRequestBuilderImpl()
    
    func performFetching<D: Decodable>(endpoint: BaseRouter, type: D.Type) async throws -> D {
        let (data, response) = try await URLSession.shared.data(for: requestBuilder.build(with: endpoint))
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw APIError.badRequest
//        }
//        do {
//            let decoder = JSONDecoder()
//            return try decoder.decode(type, from: data)
//        } catch {
//            print(error.localizedDescription)
//            throw APIError.decodingError
//        }
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.invalidResponse }
        try validateStatusCode(statusCode: httpResponse.statusCode)
        let decodedResponse = try decodeData(data, objectType: type)
        return decodedResponse
    }
}


extension APIServiceImpl {
    func validateStatusCode(statusCode: Int) throws {
        switch statusCode {
        case 200:
            return
        case 400:
            throw APIError.badRequest
        case 404:
            throw APIError.notFound
        case 500...504:
            throw APIError.serverErrors
        default:
            throw APIError.unknownError
        }
    }
    
    func decodeData<D:Decodable>(_ data: Data, objectType: D.Type) throws -> D {
        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode(D.self, from: data)
            return decodedResponse
        } catch {
            throw APIError.decodingError
        }
    }
}
