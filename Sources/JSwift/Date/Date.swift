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
    
    var dayOfWeek: Int {
        Calendar.current.component(.weekday, from: self)
    }
    
    var dayOfMonth: Int {
        Calendar.current.component(.day, from: self)
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
    
    var friendlyDescription: String {
        let calendar = Calendar.current
        let now = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInTomorrow(self) {
            return "Tomorrow"
        }
        
        let components = calendar.dateComponents([.day, .weekOfYear, .month, .year], from: now, to: self)
        let dayDifference = components.day!
        let weekDifference = components.weekOfYear!
        let monthDifference = components.month!
        let yearDifference = components.year!
        
        let weekdayToday = calendar.component(.weekday, from: now)
        let weekdayTarget = calendar.component(.weekday, from: self)
        
        // Yesterday
        if dayDifference == -1 {
            return "Yesterday"
        }
        
        // Correct handling of same week but different days
        if weekDifference == 0 {
            if dayDifference > 0 {
                if weekdayTarget > weekdayToday {
                    return "Next \(dateFormatter.string(from: self))"
                }
            } else if dayDifference < 0 {
                if weekdayTarget < weekdayToday {
                    return "Last \(dateFormatter.string(from: self))"
                }
            } else {
                return dateFormatter.string(from: self)
            }
        }
        
        // Next and last weekday handling
        if weekDifference == 1 && weekdayTarget <= weekdayToday {
            return "Next \(dateFormatter.string(from: self))"
        } else if weekDifference == -1 && weekdayTarget >= weekdayToday {
            return "Last \(dateFormatter.string(from: self))"
        }
        
        // Relative weeks
        if weekDifference == 1 {
            return "Next week"
        } else if weekDifference == -1 {
            return "Last week"
        } else if weekDifference > 1 && weekDifference < 4 {
            return "In \(weekDifference) weeks"
        } else if weekDifference < -1 && weekDifference > -4 {
            return "\(-weekDifference) weeks ago"
        }
        
        // Months
        if monthDifference == 1 {
            return "Next month"
        } else if monthDifference == -1 {
            return "Last month"
        } else if monthDifference > 1 && monthDifference < 12 {
            return "In \(monthDifference) months"
        } else if monthDifference < -1 && monthDifference > -12 {
            return "\(-monthDifference) months ago"
        }
        
        // Years
        if yearDifference == 1 {
            return "Next year"
        } else if yearDifference == -1 {
            return "Last year"
        } else if yearDifference > 1 {
            return "In \(yearDifference) years"
        } else if yearDifference < -1 {
            return "\(-yearDifference) years ago"
        }
        
        // Default to the day of the week
        return dateFormatter.string(from: self)
    }
}

public extension Date {
    
    func advanceBy(_ value: Int) -> Self {
        Calendar.current.date(byAdding: .day, value: value, to: self) ?? self
    }
    
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
