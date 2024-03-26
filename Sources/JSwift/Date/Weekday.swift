//
//  Weekday.swift
//  JSwift
//
//  Created by Jenya Lebid on 3/25/24.
//

import Foundation

public enum Weekday: String, CaseIterable, Codable {
    
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    
    public static let weekdays = [monday, tuesday, wednesday, thursday, friday]
    public static let weekends = [sunday, saturday]
}

public extension Weekday {
    
    var order: Int {
        switch self {
        case .sunday:
            1
        case .monday:
            2
        case .tuesday:
            3
        case .wednesday:
            4
        case .thursday:
            5
        case .friday:
            6
        case .saturday:
            7
        }
    }
}

public extension Weekday {
    
    static var today: Weekday {
        Date().startOfDay.weekday
    }
}
