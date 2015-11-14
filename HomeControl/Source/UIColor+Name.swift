//
//  UIColor+Name.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 14/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexadecimalColor: UInt32) {
        let red = CGFloat(hexadecimalColor >> 24 & 0xFF) / 255
        let green = CGFloat(hexadecimalColor >> 16 & 0xFF) / 255
        let blue = CGFloat(hexadecimalColor >> 8 & 0xFF) / 255
        let alpha = CGFloat(hexadecimalColor & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    convenience init<T:RawRepresentable where T.RawValue: UnsignedIntegerType>(named name: T) {
        self.init(hexadecimalColor: UInt32(name.rawValue.toUIntMax()))
    }
}
