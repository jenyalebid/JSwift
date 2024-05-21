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
        Calendar.current.date(byAdding: .day, value: 1, to: self) ?? self
    }
    
    var previousDay: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: self) ?? self
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }
    
    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }
}

public extension Date {
    
    static var  currentYear: Int {
        Date().year
    }
    
    static var  currentMonth: Int {
        Date().monthOfYear
    }
    
    static var  currentWeekOfYear: Int {
        Date().weekOfYear
    }
    
    static var currentWeekOfMonth: Int {
        Date().weekOfMonth
    }
    
    var year: Int {
        Calendar.current.component(.year, from: self)
    }
    
    var monthOfYear: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var weekOfYear: Int {
        Calendar.current.component(.weekOfYear, from: self)
    }
    
    var weekOfMonth: Int {
        Calendar.current.component(.weekOfMonth, from: self)
    }
}

public extension Date {
    
    var weekday: Weekday {
        let calendar = Calendar.current
        let weekdayIndex = calendar.component(.weekday, from: self)
        // Sunday is represented by 1, so we need to subtract 1 to match with the Weekday enum
        return Weekday.allCases[(weekdayIndex - 1) % Weekday.allCases.count]
    }
    
    var time: Time {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: self)
        
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let second = components.second ?? 0
        
        return Time(hour: hour, minute: minute, second: second)
    }
}

public extension Date {
    
    func isSame(granularity: Calendar.Component, as date: Date) -> Bool {
        Calendar.current.isDate(self, equalTo: date, toGranularity: granularity)
    }
    
    func toString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
