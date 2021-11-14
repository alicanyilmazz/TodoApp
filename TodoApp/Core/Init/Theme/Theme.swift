//
//  Theme.swift
//  TodoApp
//
//  Created by alican on 7.11.2021.
//

#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
    typealias Color = UIColor
#endif
#if os(macOS)
    import Cocoa
    typealias Color = NSColor
#endif

import RxSwift
import RxTheme

protocol Theme {
    var customCellBackgroundColor : Color { get }
    var customCellTintColor : Color { get }
    var customViewBackgroundColor : Color { get }
    var customViewTintColor : Color { get }
    var detailLblTextColor : Color { get }
    var detailLblBackgroundColor : Color { get }
    var detailLblTintColor : Color { get }
    var detailTitleLblTextColor : Color { get }
    var detailTitleLblBackgroundColor : Color { get }
    var detailTitleLblTintColor : Color { get }
    var isCompletedLblBackgroundColor : Color { get }
    var isCompletedLblTintColor : Color { get }
    var calendarAvatarBackgroundColor : Color { get }
    var calendarAvatarTintColor : Color { get }
    var dateLblTextColor : Color { get }
    var dateLblBackgroundColor : Color { get }
    var dateLblTintColor : Color { get }
    var todoTitleLblBackgroundColor : Color { get }
    var todoTitleLblTextColor : Color { get }
    var tableViewBackgroundColor : Color { get }
    var tableViewTintColor : Color { get }
    var searchBarBackgroundColor : Color { get }
    var searchBarBarTintColor : Color { get }
    var searchBarTintColor : Color { get }
    var addButtonBackgroundColor : Color { get }
    var addButtonTintColor : Color { get }
    var uiNavigationControllerForegroundColor : Color { get }
    var uiNavigationControllerBarTintColor : Color { get }
    var uiNavigationControllerTintColor : Color { get }
    var alertControllerTextFieldTextColor : Color { get }
    var alertControllerTextFieldBackgroundColor : Color { get }
    var alertControllerTextFieldTintColor : Color { get }
    var alertControllerSubviewBackgroundColor : Color { get }
    var alertControllerSubviewTintColor : Color { get }
}

struct LightTheme: Theme {
     
    let customCellBackgroundColor: Color = ColorPalette.shadowWhite
    
    let customCellTintColor: Color = ColorPalette.yellow
    
    let customViewBackgroundColor: Color = ColorPalette.cleanWhite
    
    let customViewTintColor: Color = ColorPalette.yellow
    
    let detailLblTextColor: Color = ColorPalette.lightGray
    
    let detailLblBackgroundColor: Color = ColorPalette.cleanWhite
    
    let detailLblTintColor: Color = ColorPalette.white
    
    let detailTitleLblTextColor: Color = ColorPalette.darkGray
    
    let detailTitleLblBackgroundColor: Color = ColorPalette.cleanWhite
    
    let detailTitleLblTintColor: Color = ColorPalette.white
    
    let isCompletedLblBackgroundColor: Color = ColorPalette.cleanWhite
    
    let isCompletedLblTintColor: Color = ColorPalette.yellow
    
    let calendarAvatarBackgroundColor: Color = ColorPalette.cleanWhite
    
    let calendarAvatarTintColor: Color = ColorPalette.yellow
    
    let dateLblTextColor: Color = ColorPalette.darkWhite
    
    let dateLblBackgroundColor: Color = ColorPalette.cleanWhite
    
    let dateLblTintColor: Color = ColorPalette.yellow
    
    let todoTitleLblBackgroundColor : Color = ColorPalette.cleanWhite
    
    let todoTitleLblTextColor : Color = ColorPalette.lightGray
    
    let tableViewBackgroundColor : Color = ColorPalette.smokeWhite
    
    let tableViewTintColor : Color = ColorPalette.yellow
    
    let searchBarBackgroundColor : Color = ColorPalette.black
    
    let searchBarBarTintColor : Color = ColorPalette.blueWhite
    
    let searchBarTintColor : Color = ColorPalette.darkGray
    
    let addButtonBackgroundColor : Color = ColorPalette.yellow
    
    let addButtonTintColor : Color = ColorPalette.darkGray
    
    let uiNavigationControllerForegroundColor : Color = ColorPalette.pureWhite
    
    let uiNavigationControllerBarTintColor : Color = ColorPalette.pureWhite
    
    let uiNavigationControllerTintColor : Color = ColorPalette.pureWhite
    
    var alertControllerTextFieldTextColor: Color = ColorPalette.lightGray
    
    var alertControllerTextFieldBackgroundColor: Color = ColorPalette.pureWhite
    
    var alertControllerTextFieldTintColor: Color = ColorPalette.lightGray
    
    var alertControllerSubviewBackgroundColor: Color = ColorPalette.smokeWhite
    
    var alertControllerSubviewTintColor: Color = ColorPalette.lightGray
}

struct DarkTheme: Theme {
    let customCellBackgroundColor: Color = ColorPalette.darkGray
    
    let customCellTintColor: Color = ColorPalette.yellow
    
    let customViewBackgroundColor: Color = ColorPalette.lightGray
    
    let customViewTintColor: Color = ColorPalette.yellow
    
    let detailLblTextColor: Color = ColorPalette.yellow
    
    let detailLblBackgroundColor: Color = ColorPalette.lightGray
    
    let detailLblTintColor: Color = ColorPalette.white
    
    let detailTitleLblTextColor: Color = ColorPalette.yellow
    
    let detailTitleLblBackgroundColor: Color = ColorPalette.lightGray
    
    let detailTitleLblTintColor: Color = ColorPalette.white
    
    let isCompletedLblBackgroundColor: Color = ColorPalette.lightGray
    
    let isCompletedLblTintColor: Color = ColorPalette.yellow
    
    let calendarAvatarBackgroundColor: Color = ColorPalette.lightGray
    
    let calendarAvatarTintColor: Color = ColorPalette.yellow
    
    let dateLblTextColor: Color = ColorPalette.darkWhite
    
    let dateLblBackgroundColor: Color = ColorPalette.lightGray
    
    let dateLblTintColor: Color = ColorPalette.yellow
    
    let todoTitleLblBackgroundColor : Color = ColorPalette.lightGray
    
    let todoTitleLblTextColor : Color = ColorPalette.yellow
    
    let tableViewBackgroundColor : Color = ColorPalette.darkGray
    
    let tableViewTintColor : Color = ColorPalette.yellow
    
    let searchBarBackgroundColor : Color = ColorPalette.yellow
    
    let searchBarBarTintColor : Color = ColorPalette.yellow
    
    let searchBarTintColor : Color = ColorPalette.yellow
    
    let addButtonBackgroundColor : Color = ColorPalette.yellow
    
    let addButtonTintColor : Color = ColorPalette.lightGray
    
    var uiNavigationControllerForegroundColor : Color = ColorPalette.lightBlue
    
    var uiNavigationControllerBarTintColor : Color = ColorPalette.lightBlue
    
    var uiNavigationControllerTintColor : Color = ColorPalette.yellow
    
    var alertControllerTextFieldTextColor: Color = ColorPalette.yellow
    
    var alertControllerTextFieldBackgroundColor: Color = ColorPalette.lightGray
    
    var alertControllerTextFieldTintColor: Color = ColorPalette.yellow
    
    var alertControllerSubviewBackgroundColor: Color = ColorPalette.darkGray
    
    var alertControllerSubviewTintColor: Color = ColorPalette.yellow
}

enum ThemeType: ThemeProvider {
    case light, dark
    var associatedObject: Theme {
        switch self {
        case .light:
            return LightTheme()
        case .dark:
            return DarkTheme()
        }
    }
}

let themeService = ThemeType.service(initial: .light)
func themed<T>(_ mapper: @escaping ((Theme) -> T)) -> ThemeAttribute<T> {
    return themeService.attribute(mapper)
}

