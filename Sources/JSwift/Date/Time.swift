//
//  Time.swift
//  JSwift
//
//  Created by Jenya Lebid on 5/18/24.
//

import Foundation

public struct Time: Codable, Comparable {
    
    public static func < (lhs: Time, rhs: Time) -> Bool {
        if lhs.hour != rhs.hour {
            return lhs.hour < rhs.hour
        } else if lhs.minute != rhs.minute {
            return lhs.minute < rhs.minute
        } else {
            return lhs.second < rhs.second
        }
    }
    
    public var hour: Int
    public var minute: Int
    public var second: Int
    
    public init(hour: Int, minute: Int = 0, second: Int = 0) {
        self.hour = hour
        self.minute = minute
        self.second = second
    }
    
    public func toDate() -> Date? {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: now)
        var dateComponents = DateComponents()
        dateComponents.year = components.year
        dateComponents.month = components.month
        dateComponents.day = components.day
        dateComponents.hour = self.hour
        dateComponents.minute = self.minute
        dateComponents.second = self.second
        
        return calendar.date(from: dateComponents)
    }
    
    public mutating func update(from date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: date)
        
        self.hour = components.hour ?? 0
        self.minute = components.minute ?? 0
        self.second = components.second ?? 0
    }
}

public extension Time {
    
    var isPastNow: Bool {
        Date().time > self
    }
}
