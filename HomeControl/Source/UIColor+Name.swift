//
//  UIColor+Name.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 14/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

public protocol HexadecimalColorType {
    var hexadecimalColor: UInt32 { get }
}

extension RawRepresentable where Self: HexadecimalColorType, RawValue: UnsignedIntegerType {
    var hexadecimalColor: UInt32 { return UInt32(self.rawValue.toUIntMax()) }
}

extension UIColor {
    convenience init(hexadecimalColor: UInt32) {
        let red = CGFloat(hexadecimalColor >> 24 & 0xFF) / 255
        let green = CGFloat(hexadecimalColor >> 16 & 0xFF) / 255
        let blue = CGFloat(hexadecimalColor >> 8 & 0xFF) / 255
        let alpha = CGFloat(hexadecimalColor & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    convenience init(named name: HexadecimalColorType) {
        self.init(hexadecimalColor: name.hexadecimalColor)
    }
}
