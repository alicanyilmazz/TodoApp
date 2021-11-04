//
//  UIColorExtensions.swift
//  TodoApp
//
//  Created by alican on 4.11.2021.
//

import Foundation
import UIKit

extension UIColor {
    class func randomColor(randomAlpha: Bool = false) -> UIColor {
        let redValue = CGFloat(arc4random_uniform(255)) / 255.0
        let greenValue = CGFloat(arc4random_uniform(255)) / 255.0
        let blueValue = CGFloat(arc4random_uniform(255)) / 255.0
        let alphaValue = randomAlpha ? CGFloat(arc4random_uniform(255)) / 255.0 : 1

        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
    }
    
    class func getRandomColor() -> UIColor {
        let arrColors = [#colorLiteral(red: 0.1254901961, green: 0.3882352941, blue: 0.6078431373, alpha: 1), #colorLiteral(red: 0.2352941176, green: 0.6823529412, blue: 0.6392156863, alpha: 1), #colorLiteral(red: 0.9647058824, green: 0.8352941176, blue: 0.3607843137, alpha: 1), #colorLiteral(red: 0.9294117647, green: 0.3333333333, blue: 0.231372549, alpha: 1), #colorLiteral(red: 1, green: 0.6470588235, blue: 0, alpha: 1), #colorLiteral(red: 0.8745098039, green: 0.9019607843, blue: 0.4039215686, alpha: 1), #colorLiteral(red: 0.4941176471, green: 0.6392156863, blue: 0.06274509804, alpha: 1), #colorLiteral(red: 0.9176470588, green: 0.8862745098, blue: 0.7176470588, alpha: 1), #colorLiteral(red: 0.9529411765, green: 0.7764705882, blue: 0.4666666667, alpha: 1), #colorLiteral(red: 0.7019607843, green: 0.2470588235, blue: 0.3843137255, alpha: 1), #colorLiteral(red: 0.9764705882, green: 0.337254902, blue: 0.3098039216, alpha: 1)]
        return arrColors.randomElement()!
    }
}
