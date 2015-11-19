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
        case Light
        case Dark
    }

    //MARK: Properties

    public let variant: Variant
    public let primaryColor: UIColor

    public var backgroundColor: UIColor {
        switch variant {
        case .Light:
            return UIColor(named: .LightBackground)
        case .Dark:
            return UIColor(named: .DarkBackground)
        }
    }

    public var gray: UIColor {
        switch variant {
        case .Light:
            return UIColor(named: .DarkGray)
        case .Dark:
            return UIColor(named: .LightGray)
        }
    }

    //MARK: Initialization

    public init(variant: Variant, primaryColor: UIColor.Name) {
        self.variant = variant
        self.primaryColor = UIColor(named: primaryColor)
    }
}

//MARK: Equatable

public func == (lhs: Theme, rhs: Theme) -> Bool {
    return lhs.variant == rhs.variant && lhs.primaryColor == rhs.primaryColor
}