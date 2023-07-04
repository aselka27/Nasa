//
//  DateFormatterTest.swift
//  NasaTests
//
//  Created by саргашкаева on 4.07.2023.
//

import XCTest
@testable import Nasa


class DateFormatterTests: XCTestCase {
    func testFormatDateString() {
            // ARRANGE
            let dateString = "2023-07-04T12:34:56+0000"
            let expectedFormattedDateString = "4th Jul 2023"
            
            // WHEN
            let formattedDateString = dateString.formatDateString()
            
            // THEN
            XCTAssertEqual(formattedDateString, expectedFormattedDateString)
        }
    
    func testGetDaySuffix() {
           // ARRANGE
           let days = [1, 2, 3, 4, 11, 12, 13, 21, 22, 23, 24, 31]
           let expectedSuffixes = ["st", "nd", "rd", "th", "th", "th", "th", "st", "nd", "rd", "th", "st"]
        
        for (index, day) in days.enumerated() {
            // WHEN
            let dayString = String(day)
            let suffix = dayString.getDaySuffix(day: day)
            let expectedSuffix = expectedSuffixes[index]
            // THEN
            XCTAssertEqual(suffix, expectedSuffix, "Incorrect suffix for day \(day)")
        }
    }
}
