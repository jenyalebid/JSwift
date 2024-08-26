//
//  Calendar.swift
//  JSwift
//
//  Created by Jenya Lebid on 8/25/24.
//

import Foundation

public extension Calendar {
    
    func startOfWeek(for date: Date, startingOn weekday: Int = 2) -> Date? {
        let currentWeekday = component(.weekday, from: date)
        
        // Calculate the difference between the current weekday and the desired start weekday
        let daysToSubtract = (currentWeekday - weekday + 7) % 7
        
        // Subtract the calculated number of days to get the start of the week
        return self.date(byAdding: .day, value: -daysToSubtract, to: date)
    }
}
