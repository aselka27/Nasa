//
//  SearchRouter.swift
//  Nasa
//
//  Created by саргашкаева on 28.06.2023.
//

import Foundation


enum SearchRouter {
    case search(q: String, page: Int)
}

extension SearchRouter: BaseRouter {
    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .search:
            return .GET
        }
    }
    
    var httpHeader: [HttpHeader]? {
        switch self {
        case .search:
            return nil
        }
    }
    
    var urlParameters: [URLQueryItem]? {
        switch self {
        case .search(let q, let page):
            return [.init(name: "q", value: q), .init(name: "media_type", value: "image"), .init(name: "page", value: "\(page)")]
        }
    }
    
    var bodyParameters: Data? {
        switch self {
        case .search:
            return nil
        }
    }
}
