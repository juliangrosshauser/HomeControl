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
    public let primaryColorName: ColorName

    public var primaryColor: UIColor {
        return UIColor(named: primaryColorName)
    }

    public let backgroundColor = UIColor.whiteColor()
    public let gray = UIColor(named: .Gray)
    public let barStyle = UIBarStyle.Black

    //MARK: Initialization

    public init(variant: Variant, primaryColorName: ColorName) {
        self.variant = variant
        self.primaryColorName = primaryColorName
    }
}

//MARK: Equatable

public func == (lhs: Theme, rhs: Theme) -> Bool {
    return lhs.variant == rhs.variant && lhs.primaryColorName == rhs.primaryColorName
}