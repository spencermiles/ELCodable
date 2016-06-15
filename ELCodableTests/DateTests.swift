//
//  DateTests.swift
//  ELCodable
//
//  Created by Spencer Miles on 6/15/16.
//  Copyright © 2016 WalmartLabs. All rights reserved.
//

import XCTest
import ELCodable

class DateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testEquality() {
//        let dateString: String = "2016-06-19T23:59:00-04:00"
//        let jsonValue = JSON(dateString)
//        
//        do {
//            let date = try DateISO8601(jsonValue.string!)
//            let date2 = try DateISO8601(dateString)
//            XCTAssertEqual(date, date2)
//
//        } catch {
//            XCTAssert(false, "An exception, \(error), was thrown decoding the DateISO8601")
//        }
//    }
    
    func testDefaultDecoding() {
        let date = Date<DateFormattableISO8601>()
        let date2 = Date<DateFormattableISO8601>()
        XCTAssertEqual(date, date2)
    }
    
    func testDateISO8601Decoding() {
        let dateString: String = "2016-06-19T23:59:00-04:00"
        let jsonValue = JSON(dateString)
        
        do {
            let date = try Date<DateFormattableISO8601>(jsonValue.string!)
            let date2 = try Date<DateFormattableISO8601>(dateString)
            
            XCTAssertEqual(date, date2, "dates do not match")
        } catch {
            XCTAssert(false, "An exception, \(error), was thrown decoding the iso8601 date")
        }
    }
    
    func testDateISO8601Decodable() {
        struct Receipt: Decodable {
            let date: Date<DateFormattableISO8601>
            
            static func decode(json: JSON?) throws -> Receipt {
                return try Receipt(date: json ==> "date")
            }
        }
        
        
    }
}
