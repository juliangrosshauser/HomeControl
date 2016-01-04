//
//  RoomCell.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 04/01/16.
//  Copyright © 2016 Julian Grosshauser. All rights reserved.
//

import UIKit

final class RoomCell: UITableViewCell {

    //MARK: Properties

    private(set) var room: Room?

    //MARK: Methods

    func configure(room: Room) {
        self.room = room
        textLabel?.text = room.name
    }
}
