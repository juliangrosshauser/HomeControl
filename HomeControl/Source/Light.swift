//
//  Light.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

/// Light accessory.
public struct Light: Accessory {

    //MARK: Properties

    /// Light name.
    public let name: String
    
    /// Action ID of light. Can be used to turn on/off light.
    public let actionID: String

    //MARK: Initialization

    /// Construct a `Light` with a name and action ID.
    public init(name: String, actionID: String) {
        self.name = name
        self.actionID = actionID
    }
}
