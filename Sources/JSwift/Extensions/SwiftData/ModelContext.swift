//
//  ModelContext.swift
//  JSwift
//
//  Created by Jenya Lebid on 5/11/24.
//

import Foundation
import SwiftData

public extension ModelContext {
    
    func insert<Model: PersistentModel>(_ models: [Model]) {
        models.forEach { model in
            self.insert(model)
        }
    }
    
    func model(optionalID: PersistentIdentifier?) -> (any PersistentModel)? {
        guard let optionalID else { return nil }
        return model(for: optionalID)
    }
}
