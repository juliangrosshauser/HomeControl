//
//  SetupController.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 07/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

class SetupController: UIViewController {

    //MARK: Properties

    private let serverAddressTextField: UITextField = {
        let serverAddressTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        serverAddressTextField.borderStyle = .RoundedRect
        serverAddressTextField.placeholder = "Server Address"
        return serverAddressTextField
    }()

    //MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 9/256, green: 178/256, blue: 226/256, alpha: 1)

        let logo = UIImage(named: "Logo")
        let logoView = UIImageView(image: logo)
        logoView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        logoView.center.x = view.center.x
        logoView.center.y = view.center.y - 170
        view.addSubview(logoView)

        serverAddressTextField.center = view.center
        let server = UIImage(named: "Server")
        let serverView = UIImageView(image: server)
        serverAddressTextField.leftView = serverView
        serverAddressTextField.leftViewMode = .Always
        view.addSubview(serverAddressTextField)
    }
}
