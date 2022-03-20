//
//  Color.swift
//  meep
//
//  Created by Oğuzhan Aslan on 20.03.2022.
//

import Foundation
import UIKit

enum Color {
    case primary
    case primaryVariant
    case onPrimary
    case secondary
    case secondaryVariant
    case onSecondary
    case surface
    case onSurface
    case error
    case onError
    case background
    case onBackground
}




func getUIColor(color : Color) -> UIColor {
    switch color {
        case .primary:
            return UIColor.init(named: "colorPrimary")!
        case .surface:
            return UIColor.init(named: "colorSurface")!
        case .primaryVariant:
            return UIColor.init(named: "colorPrimaryVariant")!
        case .onPrimary:
            return UIColor.init(named: "colorOnPrimary")!
        case .secondary:
            return UIColor.init(named: "colorSecondary")!
        case .secondaryVariant:
            return UIColor.init(named: "colorSecondaryVariant")!
        case .onSecondary:
            return UIColor.init(named: "colorOnSecondary")!
        case .onSurface:
            return UIColor.init(named: "colorSurface")!
        case .error:
            return UIColor.init(named: "colorError")!
        case .onError:
            return UIColor.init(named: "colorOnError")!
        case .background:
            return UIColor.init(named: "colorBackground")!
        case .onBackground:
            return UIColor.init(named: "colorOnBackground")!
    }
}

let primaryColor = getUIColor(color: .primary)
let primaryVariantColor = getUIColor(color: .primaryVariant)
let onPrimaryColor = getUIColor(color: .onPrimary)
let secondaryColor = getUIColor(color: .secondary)
let secondaryVariantColor = getUIColor(color: .secondaryVariant)
let onSecondaryColor = getUIColor(color: .onSecondary)
let surfaceColor = getUIColor(color: .surface)
let onSurfaceColor = getUIColor(color: .onSurface)
let errorColor = getUIColor(color: .error)
let onErrorColor = getUIColor(color: .onError)
let backgroundColor = getUIColor(color: .background)
let onBackgroundColor = getUIColor(color: .onBackground)
