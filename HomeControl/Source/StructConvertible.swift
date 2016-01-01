//
//  StructConvertible.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 01/01/16.
//  Copyright © 2016 Julian Grosshauser. All rights reserved.
//

public protocol StructConvertible: class {

    //MARK: Associated Types

    typealias StructType

    //MARK: Methods

    func convertToStruct() -> StructType
    func configure(item: StructType)
}
