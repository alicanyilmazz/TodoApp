//
//  AdvanceAlertController.swift
//  TodoApp
//
//  Created by alican on 12.01.2022.
//

import Foundation
import UIKit

class AdvanceAlertController{
    let validate : String.ValidityType = .between3to25
    var viewController : UIViewController?
    
    struct Constants{
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    private let backgroundView : UIView = {
       let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        //backgroundView.theme.backgroundColor = themed { $0.tableViewBackgroundColor }
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    private let alertView: UIView = {
       let alert = UIView()
        //alert.backgroundColor = UIColor.white
        alert.theme.backgroundColor = themed { $0.customAlertUI }
        alert.clipsToBounds = false
        alert.layer.shadowOpacity = 0.2
        alert.layer.shadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        alert.layer.shadowRadius = 5
        alert.layer.shadowOffset = CGSize(width: 2, height: 1)
       //alert.layer.masksToBounds = true
       alert.layer.cornerRadius = 12
       return alert
    }()
    
    private var myTargetView: UIView?
    
    lazy private var imageView:UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: alertView.frame.size.width/2-15, y: 5, width: 30, height: 30))
        imageView.image = UIImage(systemName: "bell")
        //imageView.backgroundColor = UIColor.white
        imageView.theme.backgroundColor = themed { $0.customAlertUI }
        imageView.theme.tintColor = themed { $0.customAlertUIIconColor }
        return imageView
    }()
    
    lazy private var titleLabel:UILabel = {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 40, width: alertView.frame.size.width, height: 40))
        titleLabel.text = ""
        titleLabel.textAlignment = .center
        titleLabel.theme.textColor = themed { $0.customAlertUITextTitleColor }
        //titleLabel.backgroundColor = UIColor.white
        titleLabel.theme.backgroundColor = themed { $0.customAlertUI }
        titleLabel.font = titleLabel.font.withSize(16)
        return titleLabel
    }()
    
    lazy private var messageLabel:UILabel = {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 80, width: alertView.frame.size.width, height: 60))
        messageLabel.numberOfLines = 0
        messageLabel.text = ""
        messageLabel.theme.textColor = themed { $0.customAlertUITextMessageColor }
        //messageLabel.backgroundColor = UIColor.white
        messageLabel.theme.backgroundColor = themed { $0.customAlertUI }
        messageLabel.textAlignment = .center
        messageLabel.font = messageLabel.font.withSize(13)
        return messageLabel
    }()
    
    lazy private var textField:UITextField = {
        let textField = UITextField(frame: CGRect(x: 10, y: 140, width: alertView.frame.size.width-20, height: 30))
        //textField.backgroundColor = UIColor.white
        textField.theme.backgroundColor = themed { $0.customAlertUITextFieldBackgroundColor }
        textField.theme.textColor = themed { $0.customAlertUITextFieldTextColor }
        //textField.placeholder = "Enter your todo"
        textField.text = ""
        textField.attributedPlaceholder = NSAttributedString(string: "Enter your todo", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.layer.cornerRadius = 3
        textField.clipsToBounds = false
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        textField.layer.shadowRadius = 5
        textField.layer.shadowOffset = CGSize(width: 2, height: 1)
        textField.addTarget(self, action: #selector(handleTextChanges), for: .editingChanged)
        return textField
    }()
    
    lazy private var alertLabel:UILabel={
        let alertLabel = UILabel(frame: CGRect(x: 0, y: 180, width: alertView.frame.size.width, height: 20))
        alertLabel.text = ""
        alertLabel.textColor = .systemPink
        alertLabel.textAlignment = .center
        //alertLabel.backgroundColor = UIColor.white
        alertLabel.theme.backgroundColor = themed { $0.customAlertUI }
        alertLabel.font = alertLabel.font.withSize(12)
        return alertLabel
    }()
    
    lazy private var colorButton1:UIButton={
        let colorButton1 =  UIButton(frame: CGRect(x: stackView.frame.size.width/2-55, y: 0, width: 25, height: 25))
        colorButton1.backgroundColor = .red
        colorButton1.tintColor = UIColor.red
        colorButton1.layer.cornerRadius = 3
        colorButton1.clipsToBounds = false
        colorButton1.tag = 0
        colorButton1.layer.borderColor = ColorPalette.lightGray.cgColor
        colorButton1.addTarget(self, action:#selector(setSelectedColor(_:)), for: .touchUpInside)
        return colorButton1
    }()
    
    lazy private var colorButton2:UIButton={
        let colorButton2 =  UIButton(frame: CGRect(x: stackView.frame.size.width/2-25, y: 0, width: 25, height: 25))
        //colorButton2.setImage(UIImage(systemName: "checkmark"), for: .normal)
        colorButton2.backgroundColor = .green
        colorButton2.tintColor = UIColor.green
        colorButton2.layer.cornerRadius = 3
        colorButton2.clipsToBounds = false
        colorButton2.tag = 1
        colorButton2.layer.borderColor = ColorPalette.lightGray.cgColor
        colorButton2.addTarget(self, action:#selector(setSelectedColor(_:)), for: .touchUpInside)
        return colorButton2
    }()
    lazy private var colorButton3:UIButton={
        let colorButton3 =  UIButton(frame: CGRect(x: stackView.frame.size.width/2+5, y: 0, width: 25, height: 25))
        //colorButton3.setImage(UIImage(systemName: "bell"), for: .normal)
        colorButton3.backgroundColor = .brown
        colorButton3.tintColor = UIColor.brown
        colorButton3.layer.cornerRadius = 3
        colorButton3.clipsToBounds = false
        colorButton3.tag = 2
        colorButton3.layer.borderColor = ColorPalette.lightGray.cgColor
        colorButton3.addTarget(self, action:#selector(setSelectedColor(_:)), for: .touchUpInside)
        return colorButton3
    }()
    lazy private var colorButton4:UIButton={
        let colorButton4 =  UIButton(frame: CGRect(x: stackView.frame.size.width/2+35, y: 0, width: 25, height: 25))
        //colorButton4.setImage(UIImage(systemName: "bell"), for: .normal)
        colorButton4.backgroundColor = .orange
        colorButton4.tintColor = UIColor.orange
        colorButton4.layer.cornerRadius = 3
        colorButton4.clipsToBounds = false
        colorButton4.tag = 3
        colorButton4.layer.borderColor = ColorPalette.lightGray.cgColor
        colorButton4.addTarget(self, action:#selector(setSelectedColor(_:)), for: .touchUpInside)
        return colorButton4
    }()
   
    lazy private var stackView:UIStackView={
        let stackView = UIStackView(frame: CGRect(x: 0, y: 220, width: alertView.frame.size.width, height: 28))
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        //stackView.backgroundColor = .black
        return stackView
    }()
   
    lazy private var acceptButton:UIButton={
        let acceptButton = UIButton(frame: CGRect(x: alertView.frame.size.width/2 + 5, y: alertView.frame.size.height-41, width: alertView.frame.size.width/2-10, height: 30))
        acceptButton.setTitle("Accept", for: .normal)
        acceptButton.setTitleColor(ColorPalette.black, for: .normal)
        acceptButton.theme.backgroundColor = themed { $0.customAlertUIAcceptButtonColor }
        acceptButton.layer.cornerRadius = 10
        acceptButton.clipsToBounds = false
        acceptButton.layer.shadowOpacity = 0.2
        acceptButton.layer.shadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        acceptButton.layer.shadowRadius = 5
        acceptButton.layer.shadowOffset = CGSize(width: 2, height: 1)
        acceptButton.addTarget(self, action: #selector(acceptAlert), for: .touchUpInside)
        return acceptButton
    }()
    
    lazy private var dismissButton:UIButton={
        let dismissButton = UIButton(frame: CGRect(x: 5, y: alertView.frame.size.height-40, width: alertView.frame.size.width/2-10, height: 30))
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.setTitleColor(ColorPalette.black, for: .normal)
        dismissButton.theme.backgroundColor = themed { $0.customAlertUIDismissButtonColor }
        dismissButton.layer.cornerRadius = 10
        dismissButton.clipsToBounds = false
        dismissButton.layer.shadowOpacity = 0.2
        dismissButton.layer.shadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        dismissButton.layer.shadowRadius = 5
        dismissButton.layer.shadowOffset = CGSize(width: 2, height: 1)
        dismissButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        return dismissButton
    }()
    
    func showAlert(with title: String , message: String ,on viewController: UIViewController , text : inout String?){
        guard let targetView = viewController.view else{return}
        myTargetView = targetView
        backgroundView.frame = targetView.bounds
        //backgroundView.backgroundColor = .darkGray
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width-80, height: 300)
        alertView.addSubview(imageView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(messageLabel)
        alertView.addSubview(textField)
        alertView.addSubview(alertLabel)
        alertView.addSubview(stackView)
        stackView.addSubview(colorButton1)
        stackView.addSubview(colorButton2)
        stackView.addSubview(colorButton3)
        stackView.addSubview(colorButton4)
        alertView.addSubview(acceptButton)
        alertView.addSubview(dismissButton)
        titleLabel.text = title
        messageLabel.text = message
        textField.text = text
        self.viewController = viewController as! TodoListViewController
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        },completion: { done in
            if done{
                UIView.animate(withDuration: 0.25, animations: {
                    self.alertView.center = targetView.center
                })
            }
        })
    }
    
    @objc func dismissAlert(){
        guard let targetView = myTargetView else {return}
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.frame = CGRect(x: 40, y: targetView.frame.size.height, width: targetView.frame.size.width-80, height: 300)
        },completion: { done in
            if done{
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundView.alpha = 0
                }, completion: { done in
                    if done{
                        self.imageView.removeFromSuperview()
                        self.titleLabel.removeFromSuperview()
                        self.messageLabel.removeFromSuperview()
                        self.textField.removeFromSuperview()
                        self.alertLabel.removeFromSuperview()
                        self.colorButton1.removeFromSuperview()
                        self.colorButton3.removeFromSuperview()
                        self.colorButton3.removeFromSuperview()
                        self.colorButton4.removeFromSuperview()
                        self.stackView.removeFromSuperview()
                        self.acceptButton.removeFromSuperview()
                        self.dismissButton.removeFromSuperview()
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                    }
                })
            }
        })
    }
    
    @objc func acceptAlert(){
        guard let targetView = myTargetView else {return}
        guard let text = textField.text else {return}
        
        if isValid(){
            
            UIView.animate(withDuration: 0.25, animations: {
                self.alertView.frame = CGRect(x: 40, y: targetView.frame.size.height, width: targetView.frame.size.width-80, height: 300)
            },completion: { done in
                if done{
                    UIView.animate(withDuration: 0.25, animations: {
                        self.backgroundView.alpha = 0
                    }, completion: { done in
                        if done{
                            self.imageView.removeFromSuperview()
                            self.titleLabel.removeFromSuperview()
                            self.messageLabel.removeFromSuperview()
                            self.textField.removeFromSuperview()
                            self.alertLabel.removeFromSuperview()
                            self.colorButton1.removeFromSuperview()
                            self.colorButton3.removeFromSuperview()
                            self.colorButton3.removeFromSuperview()
                            self.colorButton4.removeFromSuperview()
                            self.stackView.removeFromSuperview()
                            self.acceptButton.removeFromSuperview()
                            self.dismissButton.removeFromSuperview()
                            self.alertView.removeFromSuperview()
                            self.backgroundView.removeFromSuperview()
                        }
                    })
                }
            })
        }else{
            alertLabel.text = "is not valid"
        }
    }
    
    @objc func handleTextChanges(){
        guard let text = textField.text else { return }
        if text.isValid(validate){
            alertLabel.text = "Everything seems fine"
            alertLabel.textColor = ColorPalette.pureBlue
        }else{
            alertLabel.text = "The number of characters must be between 3-25."
            alertLabel.textColor = ColorPalette.darkpink
        }
    }
    
    fileprivate func isValid() -> Bool {
        if textField.text!.isValid(validate){
           return true
        }else{
           return false
        }
    }
 
    @objc func setSelectedColor(_ sender: UIButton) {
        let tagNumber = sender.tag
        resetColorSelected()
        let borderWidth : CGFloat = 3
        switch tagNumber{
        case ColorButtonTagMinimal.First.rawValue : colorButton1.layer.borderWidth = borderWidth
           
        case ColorButtonTagMinimal.Second.rawValue : colorButton2.layer.borderWidth = borderWidth
             
        case ColorButtonTagMinimal.Third.rawValue : colorButton3.layer.borderWidth = borderWidth
             
        case ColorButtonTagMinimal.Fourth.rawValue : colorButton4.layer.borderWidth = borderWidth
             
        default : colorButton1.layer.borderWidth = borderWidth
        }
    }
    
    func resetColorSelected(){
        colorButton1.layer.borderWidth = 0
        colorButton2.layer.borderWidth = 0
        colorButton3.layer.borderWidth = 0
        colorButton4.layer.borderWidth = 0
    }
}
