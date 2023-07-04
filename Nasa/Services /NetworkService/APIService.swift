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
    static let shared = APIServiceImpl()
    
    private let apiLog = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "API")
    
    private init() {}
    let requestBuilder: URLRequestBuilder = URLRequestBuilderImpl()
    
    func performFetching<D: Decodable>(endpoint: BaseRouter, type: D.Type) async throws -> D {
       
        let request = try requestBuilder.build(with: endpoint)
        os_log(.info, log: .network, "API Request - URL: %@, Method: %@", [request.url, request.httpMethod])
        let (data, response) = try await URLSession.shared.data(for: requestBuilder.build(with: endpoint))
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.invalidResponse }
        try validateStatusCode(statusCode: httpResponse.statusCode, data: data)
        let decodedResponse = try decodeData(data, objectType: type)
        return decodedResponse
    }
}


extension APIServiceImpl {
    func validateStatusCode(statusCode: Int, data: Data) throws {
        switch statusCode {
        case 200:
            return
        case 400:
            let decodedData = try decodeData(data, objectType: FailureModel.self)
            throw APIError.badRequest(reasong: decodedData.reason)
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
