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

    var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.backgroundColor = .whiteColor()
        return window
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        ThemeManager.currentTheme = Theme(variant: .Light, primaryColorName: .Red)
        window?.rootViewController = UINavigationController(rootViewController: SetupController(viewModel: SetupViewModel(networkManager: NetworkManager(), store: Store())))
        window?.makeKeyAndVisible()
        return true
    }
}
