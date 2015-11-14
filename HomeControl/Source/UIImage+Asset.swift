//
//  UIImage+Asset.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 13/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init<T: RawRepresentable where T.RawValue: StringLiteralConvertible>(asset: T) {
        assert(UIImage(named: String(asset.rawValue)) != nil, "No image named \"\(asset.rawValue)\" found in asset catalog")
        self.init(named: String(asset.rawValue))!
    }
}
