//
//  CustomExtension.swift
//  TodoApp
//
//  Created by alican on 15.11.2021.
//

import Foundation
import UIKit

extension CGRect{
    func setBaseButtonPosition(_ xPosition : CGFloat ,_ yPosition : CGFloat ,_ safeArea : CGFloat) -> CGRect{
       return CGRect(x: xPosition - 78, y: yPosition - 78 - safeArea, width: 60, height: 60)
    }
    
    func setChildButtonPosition(_ xPosition : CGFloat ,_ yPosition : CGFloat ,_ safeArea : CGFloat) -> CGRect{
       return CGRect(x: xPosition - 70, y: yPosition - 133 - safeArea, width: 45, height: 45)
    }
}

class Position{
    func setPosition(_ xPosition : CGFloat ,_ yPosition : CGFloat ,_ safeArea : CGFloat ,_ xShiftLength : CGFloat ,_ yShiftLength : CGFloat ,_ width : CGFloat ,_ height : CGFloat) -> CGRect{
       return CGRect(x: xPosition - xShiftLength, y: yPosition - yShiftLength - safeArea, width: width, height: height)
    }
}
