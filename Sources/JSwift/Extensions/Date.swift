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
}
