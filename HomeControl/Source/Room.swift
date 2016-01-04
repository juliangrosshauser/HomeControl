//
//  Room.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

/// Represents a room containing lights, blinds and consumers.
public struct Room {

    //MARK: Properties

    /// Room ID.
    let id: UInt
    
    /// Room name.
    let name: String
    
    /// Lights.
    let lights: [Light]?
    
    /// Blinds.
    let blinds: [Blind]?
    
    /// Consumers.
    let consumers: [Consumer]?

    //MARK: Initialization

    /// Construct a `Room` with the specified lights, blinds and consumers.
    init(id: UInt, name: String, lights: [Light]?, blinds: [Blind]?, consumers: [Consumer]?) {
        self.id = id
        self.name = name
        self.lights = lights
        self.blinds = blinds
        self.consumers = consumers
    }
}

//MARK: Equatable

extension Room: Equatable {}

public func ==(lhs: Room, rhs: Room) -> Bool {
    return lhs.id == rhs.id && lhs.name == rhs.name && lhs.lights == rhs.lights && lhs.blinds == rhs.blinds && lhs.consumers == rhs.consumers
}

// Necessary because `==` for `Room`s doesn't compile otherwise.
public func ==<T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    return lhs == rhs
}
