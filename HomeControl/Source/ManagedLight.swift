//
//  ManagedLight.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import CoreData

public final class ManagedLight: NSManagedObject, ManagedAccessory {

    //MARK: Associated Types

    public typealias AccessoryType = Light

    //MARK: Properties

    @NSManaged public private(set) var name: String
    @NSManaged public private(set) var actionID: String

    //MARK: Relationships

    @NSManaged public private(set) var room: ManagedRoom

    //MARK: ManagedAccessory

    public func configure(accessory: AccessoryType) {
        name = accessory.name
        actionID = accessory.actionID
    }
}

//MARK: ManagedObjectType

extension ManagedLight {

    public static var entityName: String {
        return "Light"
    }
}
