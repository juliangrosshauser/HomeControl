//
//  Accessory.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 22/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import Foundation

/// Representing an accessory, like lights, blinds and consumers.
public protocol Accessory {
    
    //MARK: Properties
    
    /// Accessory name
    var name: String { get }
    
    /// Action ID of accessory. Can be used to trigger accessory actions.
    var actionID: String { get }

    //MARK: Initialization

    /// Construct an `Accessory` with a name and action ID.
    init(name: String, actionID: String)
}
