//
//  String.swift
//  JSwift
//
//  Created by Jenya Lebid on 1/1/26.
//

import Foundation

public extension String {
    func normalizedKey() -> String {
        self
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .applyingTransform(.stripDiacritics, reverse: false) ?? self
    }
}
