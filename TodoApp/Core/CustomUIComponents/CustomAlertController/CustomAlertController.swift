//
//  Alert.swift
//  TodoApp
//
//  Created by alican on 2.11.2021.
//

import Foundation
import UIKit


typealias basicAlertResult = (actionTypes?,textFieldStatusTypes,[UITextField]) -> Void
//extension UIViewController{
    
    func showBasicAlert(on vc : UIViewController , customUI : CustomUI , customUIAlertController : CustomUIAlertController , completionHandler completion : @escaping basicAlertResult){
        var textFieldStatus : textFieldStatusTypes = .acceptable
        
        var alertController = UIAlertController(title: customUIAlertController.title, message: customUIAlertController.message, preferredStyle: .alert)
        
        setAttributes(alertController: &alertController, customUIAlertController: customUIAlertController)
        
        setSubView(alertController: &alertController, customUIAlertController: customUIAlertController)
                
        for custom in customUI.customUIAlertTextField {
            setAlertTextField(alertController: &alertController, customUIAlertTextField: custom)
        }
        
        for custom in customUI.customUIAlertAction {
            let alertAction = UIAlertAction(title: custom.title, style: custom.style) { (actionTapped) in
                for textfieldInAlert in alertController.textFields!{
                    if(!textfieldInAlert.text!.isEmpty)
                    {
                        textFieldStatus = .acceptable
                    }
                    else
                    {
                        textFieldStatus = .notacceptable
                    }
                }
                completion(custom.actionType, textFieldStatus, alertController.textFields!)
            }
            alertAction.setValue(custom.titleTextColor, forKey: "titleTextColor")
            alertController.addAction(alertAction)
        }
        DispatchQueue.main.async {vc.present(alertController,animated: true,completion: nil)}
    }
//}

fileprivate  func setAlertTextField(alertController: inout UIAlertController, customUIAlertTextField : CustomUIAlertTextField) {
    alertController.addTextField { textField in
        textField.placeholder = customUIAlertTextField.placeholderText
        textField.theme.textColor = themed { $0.alertControllerTextFieldTextColor }
        textField.theme.backgroundColor = themed { $0.alertControllerTextFieldBackgroundColor }
        textField.attributedPlaceholder = NSAttributedString(string: customUIAlertTextField.placeholderText, attributes: [NSAttributedString.Key.foregroundColor: customUIAlertTextField.placeholderTextColor])
        textField.theme.tintColor = themed { $0.alertControllerTextFieldTintColor }
        textField.borderStyle = .roundedRect
        let container = textField.superview
        let effectView = container?.superview?.subviews[0]
        container?.backgroundColor = .clear
        effectView?.removeFromSuperview()
    }
}

func setAttributes(alertController : inout UIAlertController , customUIAlertController : CustomUIAlertController){
    let titleKey = "attributedTitle" , messageKey = "attributedMessage"
    let titleAttribute = NSAttributedString(string: customUIAlertController.title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: customUIAlertController.titleFontSize),NSAttributedString.Key.foregroundColor : customUIAlertController.titleColor])
    let messageAttribute = NSAttributedString(string: customUIAlertController.message, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: customUIAlertController.messageFontSize),NSAttributedString.Key.foregroundColor : customUIAlertController.messageColor])
    alertController.setValue(titleAttribute, forKey: titleKey)
    alertController.setValue(messageAttribute, forKey: messageKey)
}


func setSubView(alertController : inout UIAlertController , customUIAlertController : CustomUIAlertController){
    let subview = (alertController.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
    subview.layer.cornerRadius = 1
    subview.theme.backgroundColor = themed { $0.alertControllerSubviewBackgroundColor }
    subview.theme.tintColor = themed { $0.alertControllerSubviewTintColor }
}
