//
//  UIImageExtensions.swift
//  TodoApp
//
//  Created by alican on 13.11.2021.
//

import Foundation
import UIKit

extension UIImage{
    func getSystemUIImage(systemName : String , color : UIColor) -> UIImage {
        return (UIImage(systemName: systemName)?.withTintColor(color,renderingMode: .alwaysOriginal))!
    }
    
    func getSystemUIImage(systemName : String) -> UIImage {
        return (UIImage(systemName: systemName)?.withTintColor(UIColor.getRandomColor(),renderingMode: .alwaysOriginal))!
    }
    
    func getUIImage(name : String , color : UIColor) -> UIImage {
        return (UIImage(named: name)?.withTintColor(color,renderingMode: .alwaysOriginal))!
    }
    
    func getUIImage(name : String) -> UIImage {
        return (UIImage(named: name)?.withTintColor(UIColor.getRandomColor(),renderingMode: .alwaysOriginal))!
    }
}

struct CustomImage{
    
    static let xmark : UIImage = (UIImage(systemName: ImageName.bellslash.description)?.withTintColor(ColorPalette.yellow,renderingMode: .alwaysOriginal))!
    
    static let checkmark = (UIImage(systemName: ImageName.bell.description)?.withTintColor(ColorPalette.yellow ,renderingMode: .alwaysOriginal))!
    
    static let circle = (UIImage(systemName: ImageName.circle.description)?.withTintColor(UIColor.getRandomColor() ,renderingMode: .alwaysOriginal))!
    
    static func Image(tag : Int) -> UIImage{
        let image : UIImage!
        switch tag{
        case 0 : image = UIImage(systemName: ImageName.circle.description)?.withTintColor(ColorPalette.iconBlue,renderingMode: .alwaysOriginal)
        case 1 : image = UIImage(systemName: ImageName.circle.description)?.withTintColor(ColorPalette.iconRed,renderingMode: .alwaysOriginal)
        case 2 : image = UIImage(systemName: ImageName.circle.description)?.withTintColor(ColorPalette.iconGray,renderingMode: .alwaysOriginal)
        case 3 : image = UIImage(systemName: ImageName.circle.description)?.withTintColor(ColorPalette.iconGreen,renderingMode: .alwaysOriginal)
        case 4 : image = UIImage(systemName: ImageName.circle.description)?.withTintColor(ColorPalette.iconOrange,renderingMode: .alwaysOriginal)
        case 5 : image = UIImage(systemName: ImageName.circle.description)?.withTintColor(ColorPalette.iconPurple,renderingMode: .alwaysOriginal)
        default: image = UIImage(systemName: ImageName.circle.description)?.withTintColor(ColorPalette.iconBlue,renderingMode: .alwaysOriginal)
        }
        return image
    }
}


