//
//  UITextFieldExtensions.swift
//  TodoApp
//
//  Created by alican on 15.12.2021.
//

import Foundation
import UIKit

extension UITextField{
    func setLeftIcon(_ image: UIImage){
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView : UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    func setRightIcon(_ image: UIImage){
        let iconView = UIImageView(frame: CGRect(x: -5, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView : UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
    }
}

