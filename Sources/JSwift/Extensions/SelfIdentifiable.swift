//
//  SelfIdentifiable.swift
//  JSwift
//
//  Created by Jenya Lebid on 1/10/26.
//

import Foundation

public protocol SelfIdentifiable: Identifiable {}

extension SelfIdentifiable where Self: Hashable {
    public var id: Self { self }
}
