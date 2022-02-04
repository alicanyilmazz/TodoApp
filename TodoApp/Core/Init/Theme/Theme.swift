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
    var todoExplanationSaveBtnBackgroundColor : Color { get }
    var todoExplanationSaveBtnTextColor : Color { get }
    var todoExplanationCustomViewThemeBackgroundColor : Color { get }
    var shadowColor : Color { get }
    var customAlertUI : Color { get }
    var customAlertUITextTitleColor : Color { get }
    var customAlertUITextMessageColor : Color { get }
    var customAlertUITextFieldBackgroundColor : Color { get }
    var customAlertUITextFieldTextColor : Color { get }
    var customAlertUIDismissButtonColor : Color { get }
    var customAlertUIAcceptButtonColor : Color { get }
    var customAlertUIIconColor : Color { get }
    var todoAlertBackgorundViewBackgroundColor : Color { get }
    var todoAlertViewBackgroundColor : Color { get }
    var todoAlertHeadViewBackgroundColor : Color { get }
    var todoAlertHeadViewTintColor : Color { get }
    var todoAlertHeadTitleBackgroundColor : Color { get }
    var todoAlertHeadTitleTextColor : Color { get }
    var todoAlertMessageBackgroundColor : Color { get }
    var todoAlertMessageTextColor : Color { get }
    var todoAlertTextfieldBackgroundColor : Color { get }
    var todoAlertTextfieldTextColor : Color { get }
    var todoAlertWarningLabelBackgroundColor : Color { get }
    var todoAlertWarningLabelTextColor : Color { get }
    var todoAlertAcceptButtonBackgroundColor : Color { get }
    var todoAlertAcceptButtonTextColor : Color { get }
    var todoAlertAcceptButtonTintColor : Color { get }
    var todoAlertCancelButtonBackgroundColor : Color { get }
    var todoAlertCancelButtonTextColor : Color { get }
    var todoAlertCancelButtonTintColor : Color { get }
    var PageTitleViewBackgroundColor : Color { get }
    var uiDatePickerFirtsColor : Color { get }
    var uiDatePickerSecondColor : Color { get }
    var uiDatePickerThirdColor : Color { get }
    var uiTableViewExtensionTitleColor : Color { get }
    var uiTableViewExtensionMessageColor : Color { get }
}

struct LightTheme: Theme {

    let customCellBackgroundColor: Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //ColorPalette.shadowWhite
    
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
    
    let tableViewBackgroundColor : Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)  //ColorPalette.smokeWhite
    
    let tableViewTintColor : Color = ColorPalette.yellow
    
    let searchBarBackgroundColor : Color = ColorPalette.black
    
    let searchBarBarTintColor : Color = ColorPalette.blueWhite
    
    let searchBarTintColor : Color = ColorPalette.darkGray
    
    let addButtonBackgroundColor : Color = ColorPalette.darkpink
    
    let addButtonTintColor : Color = ColorPalette.pureWhite
    
    let uiNavigationControllerForegroundColor : Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let uiNavigationControllerBarTintColor : Color = ColorPalette.yellow
    
    let uiNavigationControllerTintColor : Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //BURASI
    
    let alertControllerTextFieldTextColor: Color = ColorPalette.lightGray
    
    let alertControllerTextFieldBackgroundColor: Color = ColorPalette.pureWhite
    
    let alertControllerTextFieldTintColor: Color = ColorPalette.lightGray
    
    let alertControllerSubviewBackgroundColor: Color = ColorPalette.smokeWhite
    
    let alertControllerSubviewTintColor: Color = ColorPalette.lightGray
    
    let todoExplanationTitleTextFieldBackgroundColor: Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let todoExplanationTitleTextFieldTextColor: Color = ColorPalette.lightGray
    
    let todoExplanationDetailTextFieldBackgroundColor: Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let todoExplanationDetailTextFieldTextColor: Color = ColorPalette.lightGray
    
    let todoExplanationDetailLblBackgroundColor: Color = ColorPalette.smokeWhite
    
    let todoExplanationDetailLblTextColor: Color = ColorPalette.lightGray
    
    let todoExplanationDateTextFieldBackgroundColor: Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let todoExplanationDateTextFieldTextColor: Color = ColorPalette.lightGray
    
    let todoExplanationDateLblBackgroundColor: Color = ColorPalette.smokeWhite
    
    let todoExplanationDateLblTextColor: Color = ColorPalette.lightGray
    
    let todoExplanationCompletedSwitchOnTintColor: Color = ColorPalette.yellow
    
    let todoExplanationCompletedSwitchThumbTintColor: Color = ColorPalette.lightGray
    
    let todoExplanationCompletedSwitchLblBackgroundColor: Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let todoExplanationSaveBtnBackgroundColor: Color = ColorPalette.yellow
    
    let todoExplanationSaveBtnTextColor: Color = ColorPalette.yellow
    
    let todoExplanationCustomViewThemeBackgroundColor: Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let shadowColor: Color = UIColor.yellow
    
    let customAlertUI: Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let customAlertUITextTitleColor: Color = ColorPalette.yellow
    
    let customAlertUITextMessageColor: Color = ColorPalette.yellow
    
    let customAlertUITextFieldBackgroundColor: Color = ColorPalette.shadowWhite
    
    var customAlertUITextFieldTextColor: Color = ColorPalette.yellow
    
    let customAlertUIDismissButtonColor: Color = ColorPalette.darkpink
    
    let customAlertUIAcceptButtonColor: Color = ColorPalette.pureBlue
    
    let customAlertUIIconColor: Color = ColorPalette.yellow
    
    let todoAlertBackgorundViewBackgroundColor: Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let todoAlertViewBackgroundColor: Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let todoAlertHeadViewBackgroundColor: Color = ColorPalette.yellow
    
    let todoAlertHeadViewTintColor: Color = ColorPalette.white
    
    let todoAlertHeadTitleBackgroundColor: Color = ColorPalette.yellow
    
    let todoAlertHeadTitleTextColor: Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let todoAlertMessageBackgroundColor: Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let todoAlertMessageTextColor: Color = ColorPalette.yellow
    
    let todoAlertTextfieldBackgroundColor: Color =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let todoAlertTextfieldTextColor: Color = ColorPalette.yellow
    
    let todoAlertWarningLabelBackgroundColor: Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let todoAlertWarningLabelTextColor: Color = ColorPalette.midRed
    
    let todoAlertAcceptButtonBackgroundColor = ColorPalette.pureBlue
    
    let todoAlertAcceptButtonTextColor = ColorPalette.pureBlue
    
    let todoAlertAcceptButtonTintColor = ColorPalette.pureBlue
    
    let todoAlertCancelButtonBackgroundColor = ColorPalette.darkpink
    
    let todoAlertCancelButtonTextColor = ColorPalette.darkpink
    
    let todoAlertCancelButtonTintColor = ColorPalette.darkpink
    
    let PageTitleViewBackgroundColor = ColorPalette.yellow
    
    let uiDatePickerFirtsColor: Color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let uiDatePickerSecondColor: Color = ColorPalette.pureLightGray
    
    let uiDatePickerThirdColor: Color = ColorPalette.yellow
    
    let uiTableViewExtensionTitleColor: Color = UIColor.black
    
    let uiTableViewExtensionMessageColor: Color = UIColor.lightGray
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
    
    let uiNavigationControllerBarTintColor : Color = ColorPalette.yellow
    
    let uiNavigationControllerTintColor : Color = ColorPalette.darkGray
    
    let alertControllerTextFieldTextColor: Color = ColorPalette.yellow
    
    let alertControllerTextFieldBackgroundColor: Color = ColorPalette.lightGray
    
    let alertControllerTextFieldTintColor: Color = ColorPalette.yellow
    
    let alertControllerSubviewBackgroundColor: Color = ColorPalette.darkGray
    
    let alertControllerSubviewTintColor: Color = ColorPalette.yellow
    
    let todoExplanationTitleTextFieldBackgroundColor: Color = ColorPalette.lightGray
    
    let todoExplanationTitleTextFieldTextColor: Color = ColorPalette.yellow
    
    let todoExplanationDetailTextFieldBackgroundColor: Color = ColorPalette.lightGray
    
    let todoExplanationDetailTextFieldTextColor: Color = ColorPalette.yellow
    
    let todoExplanationDetailLblBackgroundColor: Color = ColorPalette.darkGray
    
    let todoExplanationDetailLblTextColor: Color = ColorPalette.yellow
    
    let todoExplanationDateTextFieldBackgroundColor: Color = ColorPalette.lightGray
    
    let todoExplanationDateTextFieldTextColor: Color = ColorPalette.yellow
    
    let todoExplanationDateLblBackgroundColor: Color = ColorPalette.darkGray
    
    let todoExplanationDateLblTextColor: Color = ColorPalette.yellow
    
    let todoExplanationCompletedSwitchOnTintColor: Color = ColorPalette.yellow
    
    let todoExplanationCompletedSwitchThumbTintColor: Color = ColorPalette.softYellow
    
    let todoExplanationCompletedSwitchLblBackgroundColor: Color = ColorPalette.darkGray
    
    let todoExplanationSaveBtnBackgroundColor: Color = ColorPalette.yellow
    
    let todoExplanationSaveBtnTextColor: Color = ColorPalette.pureWhite
    
    let todoExplanationCustomViewThemeBackgroundColor: Color = ColorPalette.darkGray
    
    let shadowColor: Color = UIColor.green
    
    let customAlertUI: Color = ColorPalette.darkGray
    
    let customAlertUITextTitleColor: Color = ColorPalette.yellow
    
    let customAlertUITextMessageColor: Color = ColorPalette.yellow
    
    let customAlertUITextFieldBackgroundColor: Color = ColorPalette.lightGray
    
    var customAlertUITextFieldTextColor: Color = ColorPalette.yellow
    
    let customAlertUIDismissButtonColor: Color = ColorPalette.darkpink
    
    let customAlertUIAcceptButtonColor: Color = ColorPalette.pureBlue
    
    let customAlertUIIconColor: Color = ColorPalette.yellow
    
    let todoAlertBackgorundViewBackgroundColor: Color = ColorPalette.darkGray
    
    let todoAlertViewBackgroundColor: Color = ColorPalette.lightGray
    
    let todoAlertHeadViewBackgroundColor: Color = ColorPalette.yellow
    
    let todoAlertHeadViewTintColor: Color = ColorPalette.white
    
    let todoAlertHeadTitleBackgroundColor: Color = ColorPalette.yellow
    
    let todoAlertHeadTitleTextColor: Color = ColorPalette.pureWhite
    
    let todoAlertMessageBackgroundColor: Color = ColorPalette.lightGray
    
    let todoAlertMessageTextColor: Color = ColorPalette.yellow
    
    let todoAlertTextfieldBackgroundColor: Color = ColorPalette.lightGray  //pureLightGray
    
    let todoAlertTextfieldTextColor: Color = ColorPalette.yellow
    
    let todoAlertWarningLabelBackgroundColor: Color = ColorPalette.lightGray
    
    let todoAlertWarningLabelTextColor: Color = ColorPalette.midRed
    
    let todoAlertAcceptButtonBackgroundColor = ColorPalette.iconGreen
    
    let todoAlertAcceptButtonTextColor = ColorPalette.iconGreen
    
    let todoAlertAcceptButtonTintColor = ColorPalette.iconGreen
    
    let todoAlertCancelButtonBackgroundColor = ColorPalette.darkpink
    
    let todoAlertCancelButtonTextColor = ColorPalette.darkpink
    
    let todoAlertCancelButtonTintColor = ColorPalette.darkpink
    
    let PageTitleViewBackgroundColor = ColorPalette.yellow
    
    let uiDatePickerFirtsColor: Color = ColorPalette.darkGray
    
    let uiDatePickerSecondColor: Color = ColorPalette.lightGray
    
    let uiDatePickerThirdColor: Color = ColorPalette.yellow
    
    let uiTableViewExtensionTitleColor: Color = ColorPalette.smokeWhite
    
    let uiTableViewExtensionMessageColor: Color = UIColor.lightGray
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

