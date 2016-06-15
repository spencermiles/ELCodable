//
//  Date.swift
//  ELCodable
//
//  Created by Spencer Miles on 6/15/16.
//  Copyright © 2016 WalmartLabs. All rights reserved.
//

import Foundation

public protocol DateFormattable {
    static func parse(dateString: String) throws -> NSDate
}

public class Date<T: DateFormattable> {
    let value: NSDate
    
    public init() {
        value = NSDate(timeIntervalSince1970: 0)
    }
    
    public init(_ dateString: String) throws {
        value = try T.parse(dateString)
    }
    

}

extension Date: Hashable {
    public var hashValue: Int {
        return value.hash
    }
}

public func ==<T>(lhs:Date<T>, rhs:Date<T>) -> Bool {
    return lhs.value.compare(rhs.value) == .OrderedSame
}

public struct DateFormattableISO8601: DateFormattable {
    private static let dateFormatter: NSDateFormatter = {
        var dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter
    }()
    
    public static func parse(dateString: String) throws -> NSDate {
        let dateFormatter = DateFormattableISO8601.dateFormatter
        if let date = dateFormatter.dateFromString(dateString) {
            return date
        }
        throw DecodeError.Undecodable
    }
}
