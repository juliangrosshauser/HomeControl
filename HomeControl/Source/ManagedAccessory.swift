//
//  ManagedAccessory.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import CoreData

public protocol ManagedAccessory: ManagedObjectType {

    //MARK: Properties

    var name: String { get }
    var actionID: String { get }

    //MARK: Relationships

    var room: ManagedRoom { get }
}

//MARK: ManagedObjectType

extension ManagedAccessory {

    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "name", ascending: false)]
    }
}
