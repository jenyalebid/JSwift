//
//  NSManagedObject.swift
//  JSwift
//
//  Created by Jenya Lebid on 4/22/23.
//

import CoreData

public extension NSManagedObject {
    
    func easySave() {
        managedObjectContext?.performAndWait {
            try? managedObjectContext?.save()
        }
    }
    
    func easyDelete(save: Bool = false) {
        managedObjectContext?.performAndWait {
            managedObjectContext?.delete(self)
            if save {
                try? managedObjectContext?.save()
            }
        }
    }
}

public extension NSManagedObject {
    
    static var entityName: String {
        String(describing: Self.self)
    }
}

public extension NSManagedObject {
    
    static func findObjects<Object: NSManagedObject>(by predicate: NSPredicate?, in context: NSManagedObjectContext) -> [Object] {
        let request = NSFetchRequest<NSManagedObject>(entityName: Object.entityName)
        if let predicate {
            request.predicate = predicate
        }
        request.returnsObjectsAsFaults = false
        var result: [Object] = []
        context.performAndWait {
            do {
                result = try context.fetch(request) as? [Object] ?? []
            } catch {
                print(error)
            }
        }
        return result
    }
    
    static func findObject<Object: NSManagedObject>(by predicate: NSPredicate?, in context: NSManagedObjectContext) -> Object? {
        context.performAndWait {
            let request = NSFetchRequest<Object>(entityName: Object.entityName)
            request.predicate = predicate
            request.returnsObjectsAsFaults = false
            request.fetchLimit = 1
            var result: Object?
            do {
                result = try context.fetch(request).first
            } catch {
                print(error)
            }
            return result
        }
    }
    
    static func getObjectCount(in context: NSManagedObjectContext) throws -> Int {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = self.fetchRequest()

        do {
            let objectCount = try context.count(for: fetchRequest)
            return objectCount
        } catch {
            throw error
        }
    }
}

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
