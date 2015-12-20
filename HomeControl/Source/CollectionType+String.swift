//
//  CollectionType+String.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 20/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import Foundation

extension CollectionType where Generator.Element == String {

    /// `true` iff `self` contains an element without characters.
    var containsEmptyElement: Bool {
        get {
            return self.map({
                $0.isEmpty
            }).reduce(false) { (initialValue, elementIsEmpty) in
                initialValue || elementIsEmpty
            }
        }
    }
}
