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

//MARK: StructConvertible

extension ManagedRoom: StructConvertible {

    //MARK: Associated Types

    public typealias StructType = Room

    //MARK: Methods

    public func convertToStruct() -> StructType {
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

    public func configure(item: StructType) {
        guard let managedObjectContext = managedObjectContext else {
            fatalError("Managed object needs to be inserted into managed object context before it can be configured")
        }

        id = Int32(item.id)
        name = item.name

        if let lights = item.lights {
            self.lights = Set(lights.map {
                ManagedLight.insert($0, intoContext: managedObjectContext)
            })
        }

        if let blinds = item.blinds {
            self.blinds = Set(blinds.map {
                ManagedBlind.insert($0, intoContext: managedObjectContext)
            })
        }

        if let consumers = item.consumers {
            self.consumers = Set(consumers.map {
                ManagedConsumer.insert($0, intoContext: managedObjectContext)
            })
        }
    }
}
