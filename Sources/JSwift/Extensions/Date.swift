//
//  Date.swift
//  JSwift
//
//  Created by Jenya Lebid on 10/11/23.
//

import Foundation

public extension Date {
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    var nextDay: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }
}

public extension Date {
    
    var weekday: Weekday {
        let calendar = Calendar.current
        let weekdayIndex = calendar.component(.weekday, from: self)
        // Sunday is represented by 1, so we need to subtract 1 to match with the Weekday enum
        return Weekday.allCases[(weekdayIndex - 1) % Weekday.allCases.count]
    }
}

public extension Date {
    
    func isSame(granularity: Calendar.Component, as date: Date) -> Bool {
        Calendar.current.isDate(self, equalTo: date, toGranularity: granularity)
    }
}
