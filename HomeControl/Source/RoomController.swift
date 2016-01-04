//
//  RoomController.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 04/01/16.
//  Copyright © 2016 Julian Grosshauser. All rights reserved.
//

import UIKit

final class RoomController: UITableViewController {

    //MARK: Properties

    private let viewModel: RoomViewModel
    weak var delegate: RoomControllerDelegate?

    //MARK: Initialization

    init(viewModel: RoomViewModel) {
        self.viewModel = viewModel
        super.init(style: .Plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(RoomCell.self, forCellReuseIdentifier: String(RoomCell))
    }
}

//MARK: UITableViewDataSource

extension RoomController {

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rooms.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(RoomCell)) as! RoomCell
        cell.configure(viewModel.rooms[indexPath.row])
        return cell
    }
}

//MARK: UITableViewDelegate

extension RoomController {

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.roomChanged(viewModel.rooms[indexPath.row])

        guard let splitViewController = splitViewController, detailViewController = delegate as? UIViewController else {
            return
        }

        if splitViewController.collapsed {
            splitViewController.showDetailViewController(detailViewController, sender: nil)
        } else {
            guard splitViewController.displayMode == .PrimaryOverlay else { return }
            UIView.animateWithDuration(0.3) { splitViewController.preferredDisplayMode = .PrimaryHidden }
            splitViewController.preferredDisplayMode = .Automatic
        }
    }
}
