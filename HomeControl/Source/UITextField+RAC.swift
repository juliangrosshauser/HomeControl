//
//  UITextField+RAC.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 22/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import ReactiveCocoa

public extension UITextField {
    public func rac_textSignalProducer() -> SignalProducer<String, NoError> {
        return rac_textSignal().toSignalProducer().map({ $0 as! String }).flatMapError { _ in SignalProducer.empty }
    }
}
