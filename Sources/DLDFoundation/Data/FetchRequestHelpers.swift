//
//  FetchRequestHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation
import CoreData

public extension NSFetchRequest {
    /// Initializes a fetch request configured with the given entity name, sort descriptors and predicate.
    /// - Parameters:
    ///   - entityName: The name of the entity to fetch.
    ///   - sorting: The sort descriptors to use with the fetch request.
    ///   - predicate: The predicate to use with the fetch request.
    @objc convenience init(entityName: String, sorting: [NSSortDescriptor]? = nil, predicate: NSPredicate? = nil) {
        self.init(entityName: entityName)
        self.sortDescriptors = sorting
        self.predicate = predicate
    }
}
