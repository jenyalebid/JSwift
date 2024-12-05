//
//  PersistentModel.swift
//  JSwift
//
//  Created by Jenya Lebid on 5/11/24.
//

import Foundation
import SwiftData

public extension PersistentModel {
    
    /// Delete all model instances of this type by fetch and cycle delete.
    /// - Not efficient for large data sets, use appropriate method.
    static func cycleDeleteAll(in context: ModelContext) throws {
        let descriptor = FetchDescriptor<Self>()
        let models = try context.fetch(descriptor)
        
        for model in models {
            context.delete(model)
        }
    }
    
    static func getAll(in context: ModelContext) throws -> [Self] {
        let descriptor = FetchDescriptor<Self>()
        return try context.fetch(descriptor)
    }
    
    /// Iinstantiate model in provided context by its peristent identifier.
    static func model(for identifier: PersistentIdentifier, in context: ModelContext) -> Self? {
        context.model(for: identifier) as? Self
    }
}
