//
//  SetupController.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 07/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import UIKit
import ReactiveCocoa

private final class TextField: UITextField {
    private convenience init(placeholder: String, asset: UIImage.Asset) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        widthAnchor.constraintEqualToConstant(300).active = true
        heightAnchor.constraintEqualToConstant(50).active = true
        borderStyle = .RoundedRect
        self.placeholder = placeholder
        textColor = ThemeManager.currentTheme.gray

        let image = UIImage(asset: asset).imageWithRenderingMode(.AlwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: imageView.frame.width + 5, height: imageView.frame.height)
        imageView.contentMode = .Left
        imageView.tintColor = ThemeManager.currentTheme.gray
        leftView = imageView
        leftViewMode = .Always
    }

    private override func leftViewRectForBounds(bounds: CGRect) -> CGRect {
        var rect = super.leftViewRectForBounds(bounds)
        rect.origin.x += 10
        return rect
    }
}

private extension UILabel {
    private convenience init(text: String) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.text = text
        font = UIFont.systemFontOfSize(12)
        textColor = ThemeManager.currentTheme.gray
    }
}

private extension UIStackView {
    private convenience init(arrangedSubviews views: [UIView], spacing: CGFloat, alignment: UIStackViewAlignment = .Center) {
        self.init(arrangedSubviews: views)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .Vertical
        self.alignment = alignment
        self.spacing = spacing
    }
}

class SetupController: UIViewController {

    //MARK: Properties

    private let viewModel: SetupViewModel

    private let serverAddressTextField = TextField(placeholder: "192.168.0.100", asset: .Server)
    private let usernameTextField = TextField(placeholder: "Username", asset: .User)
    private let passwordTextField = TextField(placeholder: "Password", asset: .Lock)

    private let loadButton: UIButton = {
        let loadButton = UIButton(type: .System)
        let image = UIImage(asset: .Login).imageWithRenderingMode(.AlwaysTemplate)
        loadButton.setImage(image, forState: .Normal)
        loadButton.tintColor = ThemeManager.currentTheme.backgroundColor
        loadButton.backgroundColor = ThemeManager.currentTheme.primaryColor
        let padding: CGFloat = 40
        loadButton.widthAnchor.constraintEqualToConstant(image.size.width + padding).active = true
        loadButton.heightAnchor.constraintEqualToConstant(image.size.height + padding).active = true
        loadButton.layer.cornerRadius = (image.size.width + padding) / 2
        return loadButton
    }()

    private let wrapperStackView = UIStackView(arrangedSubviews: [], spacing: 100)

    //MARK: Initialization

    init(viewModel: SetupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: UIViewController

    override func loadView() {
        let view = UIView()
        view.backgroundColor = ThemeManager.currentTheme.backgroundColor

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

        loadButton.addTarget(self, action: "loadButtonTouchDown:", forControlEvents: .TouchDown)
        loadButton.addTarget(self, action: "loadButtonTouchUpInside:", forControlEvents: .TouchUpInside)

        viewModel.serverAddress <~ serverAddressTextField.textSignalProducer()
        viewModel.username <~ usernameTextField.textSignalProducer()
        viewModel.password <~ passwordTextField.textSignalProducer()

        viewModel.loadButtonEnabled.producer.startWithNext { [unowned self] in self.loadButton.enabled = $0 }

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "HomeControl"
    }

    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass || traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass else { return }
        if traitCollection.verticalSizeClass == .Compact {
            guard wrapperStackView.axis != .Horizontal else { return }
            wrapperStackView.axis = .Horizontal
        } else {
            guard wrapperStackView.axis != .Vertical else { return }
            wrapperStackView.axis = .Vertical
        }
    }

    //MARK: Button Actions

    @objc
    private func loadButtonTouchDown(button: UIButton) {
        UIView.animateWithDuration(0.1) {
            button.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1)
        }
    }

    @objc
    private func loadButtonTouchUpInside(button: UIButton) {
        UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: {
            button.layer.transform = CATransform3DIdentity
        }, completion: nil)
        viewModel.downloadAction.apply().start()
    }
}
