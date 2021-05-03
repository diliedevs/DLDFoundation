//
//  ManagedObjectHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation
import CoreData

@available(iOS 10.0, OSX 10.12, *)
public extension NSManagedObject {
    // MARK: - Getting a Managed Object's Identity
    /// Returns the entity name for the managed object.
    class var entityName: String {
        return entity().name ?? ""
    }
    /// Returns the entity name for the managed object.
    var entityName: String {
        return entity.name ?? ""
    }
    /// Returns a `URL` containing a URI that provides an archivable reference to the managed object.
    var uri: URL {
        return objectID.uriRepresentation()
    }
    
    // MARK: - Deleting a Managed Object
    /// Deletes the managed object from the given managed object context.
    /// - Parameter context: The managed object context to delete the object from.
    func delete(from context: NSManagedObjectContext) {
        context.delete(self)
    }
    
    // MARK: - Duplicating a Managed Object
    /// Returns a duplicate of the managed object.
    ///
    /// - Parameter context: The context into which the object should be duplicated.
    /// - returns: The duplicated managed object.
    func duplicated(in context: NSManagedObjectContext) -> NSManagedObject {
        let clone      = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        let attributes = entity.attributesByName
        let relations  = entity.relationshipsByName
        
        for (key, _) in attributes { clone.setValue(value(forKey: key), forKey: key) }
        for (key, _) in relations  { clone.setValue(value(forKey: key), forKey: key) }
        
        return clone
    }
    
    // MARK: - Getting Values
    /// Returns the number of objects of the managed object using its default fetch request.
    /// - Parameter context: The context that should count the objects.
    class func count(in context: NSManagedObjectContext) -> Int {
        guard let count = try? context.count(for: Self.fetchRequest()) else { return 0 }
        return count
    }
}

public extension Sequence where Element: NSManagedObject {
    func sum<Value: Numeric>(of keyPath: KeyPath<Element, Value>) -> Value {
        self.map({ $0[keyPath: keyPath] }).reduce(0, +)
    }
}
