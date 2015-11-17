//
//  UIImage+Asset.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 15/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

public extension UIImage {
    public enum Asset: String {
        case Logo = "Logo"
        case Server = "Server"
        case User = "User"
        case Lock = "Lock"
        case Login = "Login"
    }

    public convenience init(asset: Asset) {
        assert(UIImage(named: asset.rawValue) != nil, "No image named \"\(asset.rawValue)\" found in asset catalog")
        self.init(named: asset.rawValue)!
    }
}
