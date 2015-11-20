//
//  NSUserDefaults+UIColor.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 20/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

public extension NSUserDefaults {
    public func colorForKey(key: String) -> UIColor? {
        if let colorData = dataForKey(key) {
            return NSKeyedUnarchiver.unarchiveObjectWithData(colorData) as? UIColor
        }

        return nil
    }

    public func setColor(color: UIColor, forKey key: String) {
        let colorData = NSKeyedArchiver.archivedDataWithRootObject(color)
        setObject(colorData, forKey: key)
    }
}
