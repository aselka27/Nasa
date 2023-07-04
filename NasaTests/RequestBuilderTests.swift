//
//  RequestBuilderTests.swift
//  NasaTests
//
//  Created by саргашкаева on 3.07.2023.
//

import XCTest
@testable import Nasa

class RequestBuilderTest: XCTestCase {
    
    var urlRequestBuilder: URLRequestBuilder!
    
    override func setUp() {
        super.setUp()
        urlRequestBuilder = URLRequestBuilderImpl()
    }
    
    func testBuildRequest() throws {
           // ARRANGE
        let endpoint = MockEndpoint.getExample
           
           // WHEN
           let urlRequest = try urlRequestBuilder.build(with: endpoint)
           
           // THEN
           XCTAssertEqual(urlRequest.url?.scheme, endpoint.scheme)
           XCTAssertEqual(urlRequest.url?.host, endpoint.host)
           XCTAssertEqual(urlRequest.url?.path, endpoint.path)
           XCTAssertEqual(urlRequest.httpMethod, endpoint.httpMethod.rawValue)
           XCTAssertEqual(urlRequest.httpBody, endpoint.bodyParameters)
           
           endpoint.httpHeader?.forEach { header in
               XCTAssertEqual(urlRequest.value(forHTTPHeaderField: header.name), header.value)
           }
        
        
       }
        
}


enum MockEndpoint: BaseRouter {
   case getExample
    
    var scheme: String {
        switch self {
        case .getExample:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getExample:
            return "example.com"
        }
    }
    
    var path: String {
        switch self {
        case .getExample:
            return "/api"
        }
    }
    
    var httpMethod: Nasa.HttpMethod {
        switch self {
        case .getExample:
            return .GET
        }
    }
    
    var httpHeader: [Nasa.HttpHeader]? {
        switch self {
        case .getExample:
            return nil
        }
    }
    
    var bodyParameters: Data? {
        switch self {
        case .getExample:
            return nil
        }
    }
    
    var urlParameters: [URLQueryItem]? {
        switch self {
        case .getExample:
            return [URLQueryItem(name: "param1", value: "value1")]
        }
    }
}
