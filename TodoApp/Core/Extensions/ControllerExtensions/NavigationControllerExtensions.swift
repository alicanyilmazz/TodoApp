//
//  NavigationControllerExtensions.swift
//  TodoApp
//
//  Created by alican on 13.11.2021.
//

import Foundation
import UIKit

extension UINavigationController{
    func setNavigationController(nav : UINavigationController){
        let appearance = UINavigationBarAppearance()
        nav.navigationBar.theme.tintColor = themed { $0.uiNavigationControllerBarTintColor }
        nav.navigationBar.theme.barTintColor = themed { $0.uiNavigationControllerBarTintColor }
        nav.navigationBar.theme.backgroundColor = themed { $0.uiNavigationControllerTintColor }
        let textAttributes = [NSAttributedString.Key.foregroundColor:ColorPalette.yellow,NSAttributedString.Key.font:UIFont(name: "Chalkboard SE Bold", size: 15)!]
        nav.navigationBar.titleTextAttributes = textAttributes
    }
}

/*
 
 //appearance.titleTextAttributes = [.foregroundColor: UIColor.systemPink]
 //appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
 //nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorPalette.white]
 
*/
