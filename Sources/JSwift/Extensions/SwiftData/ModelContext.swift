//
//  ModelContext.swift
//  JSwift
//
//  Created by Jenya Lebid on 5/11/24.
//

import Foundation
import SwiftData

public extension ModelContext {
    
    /// Insert model and perform save operation.
    func insertSaving<Model: PersistentModel>(_ model: Model) throws {
        self.insert(model)
        try self.save()
    }
    
    func insert<Model: PersistentModel>(_ models: [Model]) {
        models.forEach { model in
            self.insert(model)
        }
    }
    
    func model(optionalID: PersistentIdentifier?) -> (any PersistentModel)? {
        guard let optionalID else { return nil }
        return model(for: optionalID)
    }
    
    func find<Model: PersistentModel>(by predicate: Predicate<Model>) throws -> Model? {
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        
        return try self.fetch(descriptor).first
    }
    
    func search<Model: PersistentModel>(with predicate: Predicate<Model>) throws -> [Model] {
        let descriptor = FetchDescriptor(predicate: predicate)
        return try self.fetch(descriptor)
    }
}
