//
//  NasaTests.swift
//  NasaTests
//
//  Created by саргашкаева on 2.07.2023.
//

import XCTest
@testable import Nasa
import OHHTTPStubs


final class APIServiceTests: XCTestCase {
    
    var apiService: SearchService!
    
    override func setUpWithError() throws {
        apiService = SearchServiceImpl()
    }
    
    override class func tearDown() {
        HTTPStubs.removeAllStubs()
    }
    
    
    func testShouldReturnDecodedResults() async throws {
        // ARRANGE
        let expectedData = try XCTUnwrap(loadJSONData(from: "response"))
        let stubResponse = HTTPStubsResponse(data: expectedData, statusCode: 200, headers: nil)
        stub(condition: isHost("images-api.nasa.gov")) { _ in
            return stubResponse
        }
        
        do {
            // WHEN
            let results = try await apiService.performFetchRequest(with: "nasr", page: 1, pageSize: 100)
            // THEN
            XCTAssertNotNil(results)
            XCTAssertEqual(results.collection?.items?.count, 8)
        } catch {
            XCTFail("Should return decoded response")
        }
    }
    
    func testDecodingNasaResponseDTO() throws {
        // ARRANGE
        let jsonData = try XCTUnwrap(loadJSONData(from: "response"))
        
        // WHEN
        let decodedResponse = try JSONDecoder().decode(NasaResponseDTO.self, from: jsonData)
        
        // THEN
        XCTAssertNotNil(decodedResponse)
    }
    
    func testShouldReturnDecodingError() async throws {
        // ARRANGE
        stub(condition: isHost("images-api.nasa.gov")) { _ in
            if let data = try? JSONEncoder().encode("Error json") {
                return HTTPStubsResponse(data: data,
                                       statusCode: 200,
                                       headers: ["Content-Type": "application/json"])
            } else {
                fatalError("Could not encode data")
            }
        }
        do {
            // WHEN
            _ = try await apiService.performFetchRequest(with: "nasr", page: 1, pageSize: 100)
        } catch APIError.decodingError {
           // THEN
            assert(true, "Expected Error")
        } catch {
            XCTFail("Could not get Data Response")
        }
    }
    
    func testShouldReturnServerError() async throws {
        // ARRANGE
        stub(condition: isHost("images-api.nasa.gov")) { _ in
            if let data = try? JSONEncoder().encode("Error json") {
                return HTTPStubsResponse(data: data,
                                       statusCode: 500,
                                       headers: ["Content-Type": "application/json"])
            } else {
                fatalError("Could not encode data")
            }
        }
        do {
            // WHEN
            _ = try await apiService.performFetchRequest(with: "nasr", page: 1, pageSize: 100)
        } catch APIError.serverErrors {
            assert(true, "Expected error")
        } catch {
            XCTFail("Could not get Data Response")
        }
    }
    
    // Helper method to load JSON data from a file
    func loadJSONData(from fileName: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: fileName, ofType: "json") else {
            XCTFail("Failed to locate JSON file: \(fileName).json")
            return nil
        }
        print("JSON file path: \(path)")
        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }
    
    
}
