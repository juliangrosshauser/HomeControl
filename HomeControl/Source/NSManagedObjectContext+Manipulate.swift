//
//  NSManagedObjectContext+Manipulate.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 30/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {

    public func insertObject<T: NSManagedObject where T: ManagedObjectType>() -> T {
        guard let object = NSEntityDescription.insertNewObjectForEntityForName(T.entityName, inManagedObjectContext: self) as? T else {
            fatalError("Can't insert object with type \(T.self) and entity name \(T.entityName) into managed object context")
        }

        return object
    }

    public func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }

    public func performChanges(block: () -> Void) {
        performBlock {
            block()
            self.saveOrRollback()
        }
    }
}
