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
}
