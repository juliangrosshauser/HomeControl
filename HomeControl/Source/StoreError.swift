//
//  StoreError.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 20/12/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import Foundation

/// Contains the different errors `Store` can throw.
///
/// - ReadError: File can't be read.
/// - CategoryError: Category information found in structure file is insufficient or damaged.
///
enum StoreError: ErrorType {

    /// File can't be read.
    case ReadError

    /// Category information found in structure file is insufficient or damaged.
    case CategoryError
}
