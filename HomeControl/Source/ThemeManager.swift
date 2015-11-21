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
    private static let defaultTheme = Theme(variant: .Light, primaryColorName: .Blue)

    public class var currentTheme: Theme {
        get {
            if let theme = theme { return theme }
            theme = loadTheme() ?? defaultTheme
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
        userDefaults.setInteger(Int(theme.primaryColorName.rawValue), forKey: themePrimaryColorKey)
    }

    private class func loadTheme() -> Theme? {
        if let variantValue = userDefaults.valueForKey(themeVariantKey)?.integerValue,
           variant = Theme.Variant(rawValue: variantValue),
           primaryColorNameValue = userDefaults.valueForKey(themePrimaryColorKey)?.integerValue,
           primaryColorName = ColorName(rawValue: UInt32(primaryColorNameValue)) {
            return Theme(variant: variant, primaryColorName: primaryColorName)
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
