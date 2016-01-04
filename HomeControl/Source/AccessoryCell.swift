//
//  AccessoryCell.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 04/01/16.
//  Copyright © 2016 Julian Grosshauser. All rights reserved.
//

import UIKit

final class AccessoryCell: UITableViewCell {

    //MARK: Methods

    func configure(room: Room) {
        // TODO: Set up cell UI
        textLabel?.text = String(room.id)
    }
}
