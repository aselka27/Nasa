//
//  BaseRouter.swift
//  Nasa
//
//  Created by саргашкаева on 28.06.2023.
//

import Foundation



protocol BaseRouter {
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var httpHeader:  [HttpHeader]? { get }
    var urlParameters: [URLQueryItem]? { get }
    var bodyParameters: Data? { get }
}

extension BaseRouter {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "images-api.nasa.gov"
    }
}
