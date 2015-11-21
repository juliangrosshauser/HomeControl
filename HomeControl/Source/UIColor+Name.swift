//
//  UIColor+Name.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 15/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

public extension UIColor {
    public convenience init(hexadecimalColor: UInt32) {
        let red = CGFloat(hexadecimalColor >> 24 & 0xFF) / 255
        let green = CGFloat(hexadecimalColor >> 16 & 0xFF) / 255
        let blue = CGFloat(hexadecimalColor >> 8 & 0xFF) / 255
        let alpha = CGFloat(hexadecimalColor & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    public convenience init(named name: ColorName) {
        self.init(hexadecimalColor: name.rawValue)
    }
}
