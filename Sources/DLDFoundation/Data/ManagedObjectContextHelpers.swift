//
//  ManagedObjectContextHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation
import CoreData

public extension NSManagedObjectContext {
    // MARK: - Setting Merge Policy
    /// Sets the context's merge policy to merge conflicts with the object properties trumping whatever is in the store.
    func objectShouldTrumpStoreOnMerge() {
        self.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    /// Sets the context's merge policy to merge conflicts with whatever is in the store trumping the object properties.
    func storeShouldTrumpObjectOnMerge() {
        self.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    }
    
    // MARK: - Saving Changes
    func securelySave(handlingError handle: Error.Handler? = nil) {
        guard self.hasChanges else { return }
        
        do {
            try self.save()
        } catch let error {
            error.log(withMessage: "Saving Data Error", then: handle)
        }
    }
    
    // MARK: - Fetching Objects
    /// Fetches all objects for the `request` type with optional sort descriptors and fetch predicate.
    ///
    /// - Parameters:
    ///   - request: A fetch request for an entity.
    ///   - sortDescriptors: An array of sort descriptors to sort the objects by. Use an empty array (default) for no sort descriptors.
    ///   - predicate: A predicate to constrain the selection of objects to fetch. A value of `nil` (default) means no constraints.
    /// - Returns: An array of objects that meet the criteria specified by `request` fetched from the `CoreDataStack` managed object context and from the persistent stores associated with the conetxt's persistent store coordinator. If no objects match the criteria specified by `request`, `sortDescriptors`, and `predicate`, or an error occurs, returns an empty array.
    func fetch<T: NSManagedObject>(_ request: NSFetchRequest<T>, sortDescriptors: [NSSortDescriptor] = [], predicate: NSPredicate? = nil) -> [T] {
        let newRequest          = request
        request.sortDescriptors = sortDescriptors
        request.predicate       = predicate
        
        do {
            let result = try fetch(newRequest)
            return result
        } catch {
            error.log()
            return []
        }
    }
    
    /// Fetches the object of the `request` type with the given predicate.
    ///
    /// - Parameters:
    ///   - request: A fetch request for an entity.
    ///   - predicate: A predicate to constrain the selection of objects to fetch.
    /// - Returns: The first object of the `request` type that meets the criteria of the predicate, or `nil` if one could not be found.
    func fetchObject<T: NSManagedObject>(withRequest request: NSFetchRequest<T>, predicate: NSPredicate) -> T? {
        let result = fetch(request, predicate: predicate)
        
        return result.first
    }
    
    /// Returns the managed object with the specified URI in the context.
    ///
    /// - parameter uri: A `URL` object containing a URI that provides an archivable reference to the managed object.
    ///
    /// - returns: The managed object at the `uri` or `nil` if one could not be found.
    func object(withURI uri: URL) -> NSManagedObject? {
        guard
            let psc      = persistentStoreCoordinator,
            let objectID = psc.managedObjectID(forURIRepresentation: uri)
        else {
            return nil
        }
        
        return object(with: objectID)
    }
}
