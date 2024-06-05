//
//  Weekday.swift
//  JSwift
//
//  Created by Jenya Lebid on 3/25/24.
//

import Foundation

public enum Weekday: Codable {
    
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    public static let weekdays = [monday, tuesday, wednesday, thursday, friday]
    public static let weekends = [sunday, saturday]
    
    public static var allCases: [Weekday] {
        let calendar = Calendar.current
        let firstWeekday = calendar.firstWeekday

        // Adjust the order of the cases based on the system's first weekday
        let orderedCases = [sunday, monday, tuesday, wednesday, thursday, friday, saturday]
        let splitIndex = firstWeekday - 1
        
        return Array(orderedCases[splitIndex..<orderedCases.count]) + orderedCases[0..<splitIndex]
    }
    
    public init(_ weekDayNumber: Int) throws {
        let calendar = Calendar.current
        // Adjust weekDayNumber to be 0-indexed for calculation, then revert back to 1-indexed.
        let firstWeekday = calendar.firstWeekday - 1
        let adjustedWeekDayNumber = (weekDayNumber + (firstWeekday - 1)) % 7
        
        switch adjustedWeekDayNumber {
        case 0:
            self = .sunday
        case 1:
            self = .monday
        case 2:
            self = .tuesday
        case 3:
            self = .wednesday
        case 4:
            self = .thursday
        case 5:
            self = .friday
        case 6:
            self = .saturday
        default:
            throw WeekdayError.invalidWeekdayNumber
        }
    }
    
    public var intValue: Int {
        let calendar = Calendar.current
        let firstWeekday = calendar.firstWeekday
        let weekdayIndex = Weekday.allCases.firstIndex(of: self)!
        
        // Calculate the intValue based on the system's first weekday
        return (weekdayIndex + firstWeekday - 1) % 7 + 1
    }
    
    public var strValue: String {
        switch self {
        case .sunday:
            return "Sunday"
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        }
    }
}

public extension Weekday {
    
    enum WeekdayError: Error {
        case invalidWeekdayNumber
    }
}

public extension Weekday {
    
    static var today: Weekday {
        Date().startOfDay.weekday
    }
}
