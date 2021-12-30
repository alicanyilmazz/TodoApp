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
}
