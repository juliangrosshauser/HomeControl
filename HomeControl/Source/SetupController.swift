//
//  SetupController.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 07/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

private class TextField: UITextField {
    convenience init(placeholder: String, asset: UIImage.Asset) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        widthAnchor.constraintEqualToConstant(300).active = true
        heightAnchor.constraintEqualToConstant(50).active = true
        borderStyle = .RoundedRect
        self.placeholder = placeholder
        textColor = UIColor(named: .DarkGray)

        let image = UIImage(asset: asset).imageWithRenderingMode(.AlwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: imageView.frame.width + 5, height: imageView.frame.height)
        imageView.contentMode = .Left
        imageView.tintColor = UIColor(named: .DarkGray)
        leftView = imageView
        leftViewMode = .Always
    }

    override func leftViewRectForBounds(bounds: CGRect) -> CGRect {
        var rect = super.leftViewRectForBounds(bounds)
        rect.origin.x += 10
        return rect
    }
}

private extension UILabel {
    convenience init(text: String) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.text = text
        font = UIFont.systemFontOfSize(12)
        textColor = UIColor(named: .DarkGray)
    }
}

private extension UIStackView {
    convenience init(arrangedSubviews views: [UIView], spacing: CGFloat, alignment: UIStackViewAlignment = .Center) {
        self.init(arrangedSubviews: views)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .Vertical
        self.alignment = alignment
        self.spacing = spacing
    }
}

class SetupController: UIViewController {

    //MARK: Properties

    private let serverAddressTextField = TextField(placeholder: "192.168.0.100", asset: .Server)
    private let usernameTextField = TextField(placeholder: "Username", asset: .User)
    private let passwordTextField = TextField(placeholder: "Password", asset: .Lock)

    private let loadButton: UIButton = {
        let loadButton = UIButton(type: .System)
        let image = UIImage(asset: .Login).imageWithRenderingMode(.AlwaysTemplate)
        loadButton.setImage(image, forState: .Normal)
        loadButton.tintColor = .whiteColor()
        loadButton.backgroundColor = UIColor(named: .Primary)
        let padding: CGFloat = 40
        loadButton.widthAnchor.constraintEqualToConstant(image.size.width + padding).active = true
        loadButton.heightAnchor.constraintEqualToConstant(image.size.height + padding).active = true
        loadButton.layer.cornerRadius = (image.size.width + padding) / 2
        return loadButton
    }()

    private let wrapperStackView = UIStackView(arrangedSubviews: [], spacing: 100)

    //MARK: UIViewController

    override func loadView() {
        let view = UIView()

        let serverAddressLabel = UILabel(text: "Server Address")
        let serverAddressStackView = UIStackView(arrangedSubviews: [serverAddressLabel, serverAddressTextField], spacing: 10, alignment: .Leading)

        let usernameLabel = UILabel(text: "Username")
        let passwordLabel = UILabel(text: "Password")
        let usernamePasswordStackView = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField, passwordLabel, passwordTextField], spacing: 10, alignment: .Leading)

        let textFieldsStackView = UIStackView(arrangedSubviews: [serverAddressStackView, usernamePasswordStackView], spacing: 50)

        wrapperStackView.addArrangedSubview(textFieldsStackView)
        wrapperStackView.addArrangedSubview(loadButton)
        view.addSubview(wrapperStackView)

        NSLayoutConstraint(item: wrapperStackView, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: wrapperStackView, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0).active = true

        self.view = view
    }
}
