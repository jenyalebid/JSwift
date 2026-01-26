//
//  String.swift
//  JSwift
//
//  Created by Jenya Lebid on 1/1/26.
//

import Foundation

public extension String {

    func normalizedKey() -> String {
        let unicodeNormalized = self.decomposedStringWithCompatibilityMapping

        let lowercased = unicodeNormalized.lowercased()

        let noDiacritics = lowercased.applyingTransform(.stripDiacritics, reverse: false) ?? lowercased

        let replacedAmpersands = noDiacritics.replacingOccurrences(of: "&", with: "and")

        let allowedCharacters = CharacterSet.alphanumerics.union(.whitespaces)
        let noPunctuation = replacedAmpersands.unicodeScalars
            .filter { allowedCharacters.contains($0) }
            .map(String.init)
            .joined()

        let collapsedWhitespace = noPunctuation
            .split(whereSeparator: \.isWhitespace)
            .joined(separator: " ")

        return collapsedWhitespace.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
