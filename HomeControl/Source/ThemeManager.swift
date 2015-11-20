//
//  ThemeManager.swift
//  HomeControl
//
//  Created by Julian Grosshauser on 16/11/15.
//  Copyright © 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

public class ThemeManager {

    //MARK: Properties

    private static let userDefaults = NSUserDefaults.standardUserDefaults()
    private static let themeVariantKey = "ThemeVariant"
    private static let themePrimaryColorKey = "ThemePrimaryColor"
    private static var theme: Theme?

    public class var currentTheme: Theme {
        get {
            if let theme = theme { return theme }

            if let savedTheme = loadTheme() {
                theme = savedTheme
            } else {
                theme = Theme(variant: .Light, primaryColorName: .Primary)
            }

            return theme!
        }

        set(newTheme) {
            guard theme != newTheme else { return }
            saveTheme(newTheme)
            applyTheme(newTheme)
        }
    }

    private class func saveTheme(theme: Theme) {
        self.theme = theme
        userDefaults.setInteger(theme.variant.rawValue, forKey: themeVariantKey)
        userDefaults.setColor(theme.primaryColor, forKey: themePrimaryColorKey)
    }

    private class func loadTheme() -> Theme? {
        if let variantValue = userDefaults.valueForKey(themeVariantKey)?.integerValue,
           variant = Theme.Variant(rawValue: variantValue),
           primaryColor = userDefaults.colorForKey(themePrimaryColorKey) {
            return Theme(variant: variant, primaryColor: primaryColor)
        }

        return nil
    }

    private class func applyTheme(theme: Theme) {
        UINavigationBar.appearance().barTintColor = theme.primaryColor
        UITextField.appearance().tintColor = theme.primaryColor

        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().translucent = false
    }
}
