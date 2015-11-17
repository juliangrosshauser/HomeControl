//
//  Theme.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 17/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

public struct Theme: Equatable {
    public enum Variant: Int {
        case Light = 0
        case Dark = 1
    }

    //MARK: Properties

    public let variant: Variant
    public let primaryColor: UIColor.Name

    public var backgroundColor: UIColor.Name {
        switch variant {
        case .Light:
            return .LightBackground
        case .Dark:
            return .DarkBackground
        }
    }

    public var gray: UIColor.Name {
        switch variant {
        case .Light:
            return .DarkGray
        case .Dark:
            return .LightGray
        }
    }

    //MARK: Initialization

    public init(variant: Variant, primaryColor: UIColor.Name) {
        self.variant = variant
        self.primaryColor = primaryColor
    }
}

//MARK: Equatable

public func == (lhs: Theme, rhs: Theme) -> Bool {
    return lhs.variant == rhs.variant && lhs.primaryColor == rhs.primaryColor
}