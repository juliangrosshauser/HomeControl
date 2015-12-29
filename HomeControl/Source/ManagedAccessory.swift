//
//  ManagedAccessory.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import CoreData

public protocol ManagedAccessory: class {

    //MARK: Properties

    var name: String { get }
    var actionID: String { get }

    //MARK: Relationships

    var room: ManagedRoom { get }
}
