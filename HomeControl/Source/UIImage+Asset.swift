//
//  UIImage+Asset.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 13/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

extension UIImage {
    enum Asset: String {
        case Logo = "Logo"

        var image: UIImage {
            let image = UIImage(named: self.rawValue)
            assert(image != nil, "No image named \"\(self.rawValue)\" found in asset catalog")
            return image!
        }
    }

    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}
