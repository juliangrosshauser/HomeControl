//
//  AppDelegate.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 06/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: Properties

    var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.backgroundColor = .whiteColor()
        return window
    }()

    private let store = Store()

    //MARK: UIApplicationDelegate

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window?.rootViewController = UINavigationController(rootViewController: setupRootViewController(fetchRooms()))
        window?.makeKeyAndVisible()
        return true
    }

    //MARK: Helpers

    private func fetchRooms() -> [Room] {
        let request = ManagedRoom.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        request.relationshipKeyPathsForPrefetching = ["lights", "blinds", "consumers"]

        do {
            guard let managedRooms = try store.context.executeFetchRequest(request) as? [ManagedRoom] else {
                fatalError("Fetched objects should be of type ManagedRoom")
            }

            var rooms: [Room]?
            store.context.performBlockAndWait {
                rooms = managedRooms.map {
                    $0.convertToStruct()
                }
            }

            if let rooms = rooms {
                return rooms
            }

            fatalError("Couldn't convert managed rooms to structs")
        } catch {
            fatalError("Executing fetch request failed")
        }
    }

    private func setupRootViewController(rooms: [Room]) -> UIViewController {
        if rooms.isEmpty {
            return SetupController(viewModel: SetupViewModel(store: store))
        }

        // TODO: Set up UI
        return UIViewController()
    }
}
