//
//  Collection.swift
//  JSwift
//
//  Created by Jenya Lebid on 10/3/25.
//

import Foundation

public extension Collection {
    
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
