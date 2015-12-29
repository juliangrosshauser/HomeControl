//
//  Store.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import CoreData

/// Sets up Core Data stack and gives access to managed object context.
public final class Store {

    //MARK: Properties

    /// Managed object context.
    public let context: NSManagedObjectContext

    //MARK: Initialization

    /// Construct `Store` by setting up Core Data stack.
    public init() {
        // Use `NSBundle(forClass:)` so that the code still works if it's moved to a different module.
        let bundle = NSBundle(forClass: Store.self)

        guard let model = NSManagedObjectModel.mergedModelFromBundles([bundle]) else {
            fatalError("Model not found")
        }

        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        let storeURL = NSURL.documentDirectory.URLByAppendingPathComponent("HomeControl.sqlite")

        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        } catch {
            fatalError("Couldn't add persistent store to coordinator: \(error)")
        }

        context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
    }
}
