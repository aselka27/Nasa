//
//  APIService.swift
//  Nasa
//
//  Created by саргашкаева on 28.06.2023.
//

import Foundation
import os


protocol APIService {
    func performFetching<D: Decodable>(endpoint: BaseRouter, type: D.Type) async throws -> D
}


class APIServiceImpl: APIService {
    
    let requestBuilder: URLRequestBuilder = URLRequestBuilderImpl()
    
    func performFetching<D: Decodable>(endpoint: BaseRouter, type: D.Type) async throws -> D {
        let request = try requestBuilder.build(with: endpoint)
        os_log(.info, log: .network, "API Request - URL: %@, Method: %@", request.url! as CVarArg, request.httpMethod!)
        
        let (data, response) = try await URLSession.shared.data(for: requestBuilder.build(with: endpoint))
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.invalidResponse }
        try validateStatusCode(statusCode: httpResponse.statusCode, data: data)
        return try decodeData(data, objectType: type)
    }
}


extension APIServiceImpl {
    func validateStatusCode(statusCode: Int, data: Data) throws {
        switch statusCode {
        case 200:
            return
        case 400:
            let decodedData = try decodeData(data, objectType: FailureModel.self)
            os_log(.info, log: .network, "API Request FAILED - status code 400: %@", [decodedData.reason])
            throw APIError.badRequest(reasong: decodedData.reason)
        case 404:
            throw APIError.notFound
        case 500...504:
            os_log(.info, log: .network, "API Request FAILED - status code 500")
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
        } catch let error as DecodingError {
            if case let .keyNotFound(key, context) = error {
                let failedKey = key.stringValue
                os_log(.info, "API Request FAILED to decode key %@ - Context: %@", failedKey, context.debugDescription)
            }
            throw APIError.decodingError
        }
    }
}
