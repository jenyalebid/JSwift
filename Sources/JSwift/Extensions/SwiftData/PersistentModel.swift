//
//  PersistentModel.swift
//  JSwift
//
//  Created by Jenya Lebid on 5/11/24.
//

import Foundation
import SwiftData

public extension PersistentModel {
    
    static func deleteAll(in context: ModelContext) throws {
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
}
