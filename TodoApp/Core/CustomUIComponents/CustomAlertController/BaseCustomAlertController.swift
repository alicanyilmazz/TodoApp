//
//  BaseCustomAlertController.swift
//  TodoApp
//
//  Created by alican on 4.11.2021.
//

import Foundation
import UIKit

enum actionTypes{
    case save
    case cancel
    case add
    case edit
}

enum textFieldStatusTypes{
    case acceptable
    case notacceptable
}

struct CustomUI{
    let customUIAlertTextField : [CustomUIAlertTextField]
    let customUIAlertAction : [CustomUIAlertAction]
    
    init(customUIAlertTextField : [CustomUIAlertTextField] , customUIAlertAction : [CustomUIAlertAction]){
        self.customUIAlertTextField = customUIAlertTextField
        self.customUIAlertAction = customUIAlertAction
    }
}

struct CustomUIAlertTextField{
    let placeholderText : String
    let placeholderTextColor : UIColor
    let textfieldTextColor : UIColor
    let textFieldBackgroundColor : UIColor
    let textFieldTintColor : UIColor
    
    static let add : CustomUIAlertTextField = .init(placeholderText: "Enter your todo", placeholderTextColor: #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1), textfieldTextColor: #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1), textFieldBackgroundColor: #colorLiteral(red: 0.1215686275, green: 0.1607843137, blue: 0.2, alpha: 1), textFieldTintColor: .orange)
    
    static let edit : CustomUIAlertTextField = .init(placeholderText: "Enter your todo", placeholderTextColor: #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1), textfieldTextColor: #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1), textFieldBackgroundColor: #colorLiteral(red: 0.1215686275, green: 0.1607843137, blue: 0.2, alpha: 1), textFieldTintColor: .orange)
}

struct CustomUIAlertAction{
    let title : String
    let style : UIAlertAction.Style
    let titleTextColor : UIColor
    let actionType : actionTypes
    
    static let edit : CustomUIAlertAction = CustomUIAlertAction(title: "Edit", style: UIAlertAction.Style.default, titleTextColor: #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1), actionType: actionTypes.edit)
    
    static let add : CustomUIAlertAction = CustomUIAlertAction(title: "Add", style: UIAlertAction.Style.default, titleTextColor: #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1), actionType: actionTypes.add)
    
    static let cancel : CustomUIAlertAction = CustomUIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, titleTextColor: #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1), actionType: actionTypes.cancel)
}

struct CustomUIAlertController{
    let title : String
    let message : String
    let titleColor : UIColor
    let messageColor : UIColor
    let titleFontSize : CGFloat
    let messageFontSize : CGFloat
    let backgroundColor : UIColor
    let cornerRadius : CGFloat
    let tintColor : UIColor
    
    static let edit : CustomUIAlertController = .init(title: "Edit", message: "Please enter your todo title.", titleColor: #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1), messageColor: #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1), titleFontSize: 15, messageFontSize: 14, backgroundColor: #colorLiteral(red: 0.1960784314, green: 0.2470588235, blue: 0.2941176471, alpha: 0.8501358537), cornerRadius: 1, tintColor: .yellow)
    
    static let add : CustomUIAlertController = .init(title: "Add", message: "Please enter your todo title.", titleColor: #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1), messageColor: #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1), titleFontSize: 15, messageFontSize: 14, backgroundColor: #colorLiteral(red: 0.1960784314, green: 0.2470588235, blue: 0.2941176471, alpha: 0.8501358537), cornerRadius: 1, tintColor: .yellow)
}
