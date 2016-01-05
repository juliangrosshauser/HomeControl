//
//  AccessoryController.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 04/01/16.
//  Copyright © 2016 Julian Grosshauser. All rights reserved.
//

import UIKit

final class AccessoryController: UITableViewController {

    //MARK: Properties

    private var viewModel: AccessoryViewModel
    private(set) var room: Room?

    //MARK: Initialization

    init(viewModel: AccessoryViewModel) {
        self.viewModel = viewModel
        super.init(style: .Grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(AccessoryCell.self, forCellReuseIdentifier: String(AccessoryCell))
    }
}

//MARK: UITableViewDataSource

extension AccessoryController {

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Lights"
        case 1:
            return "Blinds"
        case 2:
            return "Consumers"
        default:
            return nil
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let room = viewModel.room else {
            return 0
        }

        switch section {
        case 0:
            return room.lights?.count ?? 0
        case 1:
            return room.blinds?.count ?? 0
        case 2:
            return room.consumers?.count ?? 0
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(AccessoryCell)) as! RoomCell
        if let room = viewModel.room {
            cell.configure(room)
        }
        return cell
    }
}

//MARK: RoomControllerDelegate

extension AccessoryController: RoomControllerDelegate {

    func roomChanged(room: Room) {
        viewModel.room = room
    }
}
