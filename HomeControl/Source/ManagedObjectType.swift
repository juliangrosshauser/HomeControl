//
//  ManagedObjectType.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import CoreData

public protocol ManagedObjectType: class {

    //MARK: Static Properties

    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}

extension ManagedObjectType {

    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }

    public static var sortedFetchRequest: NSFetchRequest {
        let request = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
}

//MARK: NSManagedObject

extension ManagedObjectType where Self: NSManagedObject {

    public static func findOrCreateInContext(context: NSManagedObjectContext, matchingPredicate predicate: NSPredicate, configure: Self -> Void) -> Self {
        if let object = findOrFetchInContext(context, matchingPredicate: predicate) {
            return object
        }

        let object: Self = context.insertObject()
        configure(object)
        return object
    }


    public static func findOrFetchInContext(context: NSManagedObjectContext, matchingPredicate predicate: NSPredicate) -> Self? {
        if let object = materializedObjectInContext(context, matchingPredicate: predicate) {
            return object
        }

        return fetchInContext(context) { request in
            request.predicate = predicate
            request.returnsObjectsAsFaults = false
            request.fetchLimit = 1
        }.first
    }

    public static func materializedObjectInContext(context: NSManagedObjectContext, matchingPredicate predicate: NSPredicate) -> Self? {
        for object in context.registeredObjects where !object.fault {
            guard let result = object as? Self where predicate.evaluateWithObject(result) else {
                continue
            }

            return result
        }

        return nil
    }

    public static func fetchInContext(context: NSManagedObjectContext, @noescape configure: NSFetchRequest -> Void = { _ in }) -> [Self] {
        let request = NSFetchRequest(entityName: Self.entityName)
        configure(request)

        do {
            guard let result = try context.executeFetchRequest(request) as? [Self] else {
                fatalError("Fetched objects should be of type \(Self.self)")
            }

            return result
        } catch {
            fatalError("Executing fetch request failed")
        }
    }
}

//MARK: StructConvertible

extension ManagedObjectType where Self: NSManagedObject, Self: StructConvertible {

    public static func insert(item: StructType, intoContext context: NSManagedObjectContext) -> Self {
        let managedObject: Self = context.insertObject()
        managedObject.configure(item)
        return managedObject
    }
}
