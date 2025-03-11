//
//  Optional.swift
//  JSwift
//
//  Created by Jenya Lebid on 2/27/25.
//

import Foundation


public extension Optional where Wrapped: RangeReplaceableCollection {

    mutating func appendOptional(_ newElement: Wrapped.Element) {
        if self == nil {
            self = Wrapped()
        }
        self?.append(newElement)
    }
}
