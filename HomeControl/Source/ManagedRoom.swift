//
//  ManagedRoom.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import CoreData

public final class ManagedRoom: NSManagedObject {

    //MARK: Properties

    @NSManaged public private(set) var id: Int32
    @NSManaged public private(set) var name: String

    public var immutable: Room {
        let immutableLights = lights?.map {
            $0.immutable
        }

        let immutableBlinds = blinds?.map {
            $0.immutable
        }

        let immutableConsumers = consumers?.map {
            $0.immutable
        }

        return Room(id: UInt(id), name: name, lights: immutableLights, blinds: immutableBlinds, consumers: immutableConsumers)
    }

    //MARK: Relationships

    @NSManaged public private(set) var lights: Set<ManagedLight>?
    @NSManaged public private(set) var blinds: Set<ManagedBlind>?
    @NSManaged public private(set) var consumers: Set<ManagedConsumer>?
}

//MARK: ManagedObjectType

extension ManagedRoom: ManagedObjectType {

    public static var entityName: String {
        return "Room"
    }

    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "name", ascending: false)]
    }
}
