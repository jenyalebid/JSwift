//
//  NSManagedObject.swift
//  JSwift
//
//  Created by Jenya Lebid on 4/22/23.
//

import CoreData

public extension NSManagedObject {
    
    func transfer(to context: NSManagedObjectContext) -> Self? {
        context.performAndWait {
            return try? context.existingObject(with: self.objectID) as? Self
        }
    }
}

public extension NSManagedObject {
    
    static func deleteAll(in context: NSManagedObjectContext) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: self))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
        }
        catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
