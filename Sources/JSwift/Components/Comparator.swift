//
//  Comparator.swift
//  JSwift
//
//  Created by Jenya Lebid on 2/27/25.
//

public enum Comparator: String, Codable {
    case exactly
    case notEqual
    case lessThan
    case lessThanOrEqual
    case greaterThan
    case greaterThanOrEqual

    /// Compares two values of any Comparable type based on the comparator case.
    public func compare<T: Comparable>(_ lhs: T, _ rhs: T) -> Bool {
        switch self {
        case .exactly:
            return lhs == rhs
        case .notEqual:
            return lhs != rhs
        case .lessThan:
            return lhs < rhs
        case .lessThanOrEqual:
            return lhs <= rhs
        case .greaterThan:
            return lhs > rhs
        case .greaterThanOrEqual:
            return lhs >= rhs
        }
    }
}
