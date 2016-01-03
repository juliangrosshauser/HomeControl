//
//  PrefixedStringConstant.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 03/01/16.
//  Copyright © 2016 Julian Grosshauser. All rights reserved.
//

public protocol PrefixedStringConstant: CustomStringConvertible {}

extension PrefixedStringConstant where Self: RawRepresentable, Self.RawValue == String {

    private var prefix: String {
        return "HomeControl"
    }

    //MARK: CustomStringConvertible

    public var description: String {
        return prefix + rawValue
    }
}
