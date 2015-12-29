//
//  NSURL+DocumentDirectory.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 29/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import Foundation

public extension NSURL {

    /// Returns the document directory in the user domain.
    public static var documentDirectory: NSURL {
        let fileManager = NSFileManager.defaultManager()
        let documentDirectories = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return documentDirectories[documentDirectories.count - 1]
    }
}