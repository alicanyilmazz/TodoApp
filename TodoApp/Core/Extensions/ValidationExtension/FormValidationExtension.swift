//
//  FormValidationExtension.swift
//  TodoApp
//
//  Created by alican on 13.12.2021.
//

import UIKit
import Foundation

extension String{
    
    enum ValidityType{
        case age
        case email
        case password
        case mustBeEightCharacter
        case between3to25
        case between8to42
    }
    
    enum Regex:String{
        case age = "[0-9]{2,2}"
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case password = "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$"
        case mustBeEightCharacter = ".{8}"
        case between3to25 = "^.{3,25}$"
        case between8to42 = "^.{8,42}$"
    }
    
    func isValid(_ validityType : ValidityType) -> Bool{
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
        case .age:
            regex = Regex.age.rawValue
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        case .mustBeEightCharacter:
            regex = Regex.mustBeEightCharacter.rawValue
        case .between3to25:
            regex = Regex.between3to25.rawValue
        case .between8to42:
            regex = Regex.between8to42.rawValue
        }
        
        return NSPredicate(format: format , regex).evaluate(with: self)
    }
}

/*

 Our Regex is = "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$"
 
 REGEX EXPLANATION
 
 ^                         Start anchor
 (?=.*[A-Z].*[A-Z])        Ensure string has two uppercase letters.
 (?=.*[!@#$&*])            Ensure string has one special case letter.
 (?=.*[0-9].*[0-9])        Ensure string has two digits.
 (?=.*[a-z].*[a-z].*[a-z]) Ensure string has three lowercase letters.
 .{8}                      Ensure string is of length 8.
 $                         End anchor.
 
 */

