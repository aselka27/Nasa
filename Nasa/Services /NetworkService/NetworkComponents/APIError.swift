//
//  APIError.swift
//  Nasa
//
//  Created by саргашкаева on 28.06.2023.
//

import Foundation


enum APIError: Error {
    case badRequest
    case notFound
    case serverErrors
    case decodingError
    case unknownError
    case invalidResponse
}

