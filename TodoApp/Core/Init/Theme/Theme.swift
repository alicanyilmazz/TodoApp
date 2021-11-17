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
    var todoExplanationTitleTextFieldBackgroundColor : Color { get }
    var todoExplanationTitleTextFieldTextColor : Color { get }
    var todoExplanationTitleLblBackgroundColor : Color { get }
    var todoExplanationTitleLblTextColor : Color { get }
    var todoExplanationDetailTextFieldBackgroundColor : Color { get }
    var todoExplanationDetailTextFieldTextColor : Color { get }
    var todoExplanationDetailLblBackgroundColor : Color { get }
    var todoExplanationDetailLblTextColor : Color { get }
    var todoExplanationDateTextFieldBackgroundColor : Color { get }
    var todoExplanationDateTextFieldTextColor : Color { get }
    var todoExplanationDateLblBackgroundColor : Color { get }
    var todoExplanationDateLblTextColor : Color { get }
    var todoExplanationCompletedSwitchOnTintColor : Color { get }
    var todoExplanationCompletedSwitchThumbTintColor : Color { get }
    var todoExplanationCompletedSwitchLblBackgroundColor : Color { get }
    var todoExplanationCompletedSwitchLblTextColor : Color { get }
    var todoExplanationSaveBtnBackgroundColor : Color { get }
    var todoExplanationSaveBtnTextColor : Color { get }

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
    
    let addButtonBackgroundColor : Color = ColorPalette.darkpink
    
    let addButtonTintColor : Color = ColorPalette.pureWhite
    
    let uiNavigationControllerForegroundColor : Color = ColorPalette.pureWhite
    
    let uiNavigationControllerBarTintColor : Color = ColorPalette.pureWhite
    
    let uiNavigationControllerTintColor : Color = ColorPalette.pureWhite
    
    let alertControllerTextFieldTextColor: Color = ColorPalette.lightGray
    
    let alertControllerTextFieldBackgroundColor: Color = ColorPalette.pureWhite
    
    let alertControllerTextFieldTintColor: Color = ColorPalette.lightGray
    
    let alertControllerSubviewBackgroundColor: Color = ColorPalette.smokeWhite
    
    let alertControllerSubviewTintColor: Color = ColorPalette.lightGray
    
    var todoExplanationTitleTextFieldBackgroundColor: Color = ColorPalette.shadowWhite
    
    var todoExplanationTitleTextFieldTextColor: Color = ColorPalette.lightGray
    
    var todoExplanationTitleLblBackgroundColor: Color = ColorPalette.smokeWhite
    
    var todoExplanationTitleLblTextColor: Color = ColorPalette.lightGray
    
    var todoExplanationDetailTextFieldBackgroundColor: Color = ColorPalette.shadowWhite
    
    var todoExplanationDetailTextFieldTextColor: Color = ColorPalette.lightGray
    
    var todoExplanationDetailLblBackgroundColor: Color = ColorPalette.smokeWhite
    
    var todoExplanationDetailLblTextColor: Color = ColorPalette.lightGray
    
    var todoExplanationDateTextFieldBackgroundColor: Color = ColorPalette.shadowWhite
    
    var todoExplanationDateTextFieldTextColor: Color = ColorPalette.lightGray
    
    var todoExplanationDateLblBackgroundColor: Color = ColorPalette.smokeWhite
    
    var todoExplanationDateLblTextColor: Color = ColorPalette.lightGray
    
    var todoExplanationCompletedSwitchOnTintColor: Color = ColorPalette.yellow
    
    var todoExplanationCompletedSwitchThumbTintColor: Color = ColorPalette.lightGray
    
    var todoExplanationCompletedSwitchLblBackgroundColor: Color = ColorPalette.smokeWhite

    var todoExplanationCompletedSwitchLblTextColor: Color = ColorPalette.lightGray
    
    var todoExplanationSaveBtnBackgroundColor: Color = ColorPalette.yellow
    
    var todoExplanationSaveBtnTextColor: Color = ColorPalette.yellow
    
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
    
    let addButtonBackgroundColor : Color = ColorPalette.black
    
    let addButtonTintColor : Color = ColorPalette.pureWhite
    
    let uiNavigationControllerForegroundColor : Color = ColorPalette.lightBlue
    
    let uiNavigationControllerBarTintColor : Color = ColorPalette.lightBlue
    
    let uiNavigationControllerTintColor : Color = ColorPalette.yellow
    
    let alertControllerTextFieldTextColor: Color = ColorPalette.yellow
    
    let alertControllerTextFieldBackgroundColor: Color = ColorPalette.lightGray
    
    let alertControllerTextFieldTintColor: Color = ColorPalette.yellow
    
    let alertControllerSubviewBackgroundColor: Color = ColorPalette.darkGray
    
    let alertControllerSubviewTintColor: Color = ColorPalette.yellow
    
    var todoExplanationTitleTextFieldBackgroundColor: Color = ColorPalette.lightGray
    
    var todoExplanationTitleTextFieldTextColor: Color = ColorPalette.yellow
    
    var todoExplanationTitleLblBackgroundColor: Color = ColorPalette.darkGray
    
    var todoExplanationTitleLblTextColor: Color = ColorPalette.yellow
    
    var todoExplanationDetailTextFieldBackgroundColor: Color = ColorPalette.lightGray
    
    var todoExplanationDetailTextFieldTextColor: Color = ColorPalette.yellow
    
    var todoExplanationDetailLblBackgroundColor: Color = ColorPalette.darkGray
    
    var todoExplanationDetailLblTextColor: Color = ColorPalette.yellow
    
    var todoExplanationDateTextFieldBackgroundColor: Color = ColorPalette.lightGray
    
    var todoExplanationDateTextFieldTextColor: Color = ColorPalette.yellow
    
    var todoExplanationDateLblBackgroundColor: Color = ColorPalette.darkGray
    
    var todoExplanationDateLblTextColor: Color = ColorPalette.yellow
    
    var todoExplanationCompletedSwitchOnTintColor: Color = ColorPalette.yellow
    
    var todoExplanationCompletedSwitchThumbTintColor: Color = ColorPalette.softYellow
    
    var todoExplanationCompletedSwitchLblBackgroundColor: Color = ColorPalette.darkGray
    
    var todoExplanationCompletedSwitchLblTextColor: Color = ColorPalette.yellow
    
    var todoExplanationSaveBtnBackgroundColor: Color = ColorPalette.yellow
    
    var todoExplanationSaveBtnTextColor: Color = ColorPalette.pureWhite
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

