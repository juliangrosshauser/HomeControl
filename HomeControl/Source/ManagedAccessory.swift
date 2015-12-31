//
//  ManagedAccessory.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import CoreData

public protocol ManagedAccessory: ManagedObjectType {

    //MARK: Associated Types

    typealias AccessoryType: Accessory

    //MARK: Properties

    var name: String { get }
    var actionID: String { get }

    //MARK: Relationships

    var room: ManagedRoom { get }

    //MARK: ManagedAccessory

    func configure(accessory: AccessoryType)
}

extension ManagedAccessory {

    //MARK: ManagedObjectType

    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "name", ascending: false)]
    }

    //MARK: ManagedAccessory

    public var immutable: AccessoryType {
        return AccessoryType(name: name, actionID: actionID)
    }
}

//MARK: NSManagedObject

extension ManagedAccessory where Self: NSManagedObject {

    public static func insert(accessory: AccessoryType, intoContext context: NSManagedObjectContext) -> Self {
        let managedAccessory: Self = context.insertObject()
        managedAccessory.configure(accessory)
        return managedAccessory
    }
}
