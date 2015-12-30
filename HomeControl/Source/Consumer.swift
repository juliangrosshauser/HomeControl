//
//  Consumer.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

/// Consumer accessory.
public struct Consumer: Accessory {

    //MARK: Properties

    /// Consumer name.
    public let name: String
    
    /// Action ID of consumer. Can be used to turn on/off consumer.
    public let actionID: String

    //MARK: Initialization

    /// Construct a `Consumer` with a name and action ID.
    public init(name: String, actionID: String) {
        self.name = name
        self.actionID = actionID
    }
}
