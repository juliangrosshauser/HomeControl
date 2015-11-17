//
//  Box.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 17/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

public final class Box<T: Equatable>: Equatable {

    //MARK: Properties

    public let value: T

    //MARK: Initialization

    public init(value: T) {
        self.value = value
    }
}

//MARK: Equatable

public func == <T>(lhs: Box<T>, rhs: Box<T>) -> Bool {
    return lhs.value == rhs.value
}
