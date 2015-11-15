//
//  UIColor+Name.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 15/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

extension UIColor {
    enum Name: UInt32 {
        case Primary = 0x60CAFAFF
        case Gray = 0xCECECEFF
        case LightGray = 0xF4F4F4FF
        case DarkGray = 0x404040FF
    }

    convenience init(hexadecimalColor: UInt32) {
        let red = CGFloat(hexadecimalColor >> 24 & 0xFF) / 255
        let green = CGFloat(hexadecimalColor >> 16 & 0xFF) / 255
        let blue = CGFloat(hexadecimalColor >> 8 & 0xFF) / 255
        let alpha = CGFloat(hexadecimalColor & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    convenience init(named name: Name) {
        self.init(hexadecimalColor: name.rawValue)
    }
}
