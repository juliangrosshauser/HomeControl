//
//  ManagedBlind.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import CoreData

public final class ManagedBlind: NSManagedObject, ManagedAccessory {

    //MARK: Associated Types

    public typealias AccessoryType = Blind

    //MARK: Properties

    @NSManaged public private(set) var name: String
    @NSManaged public private(set) var actionID: String

    //MARK: Relationships

    @NSManaged public private(set) var room: ManagedRoom
}

//MARK: ManagedObjectType

extension ManagedBlind {

    public static var entityName: String {
        return "Blind"
    }
}
