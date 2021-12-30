//
//  UImageEnums.swift
//  TodoApp
//
//  Created by alican on 13.11.2021.
//

import Foundation

enum ImageName : CustomStringConvertible {
  case circle
  case moon
  case bell
  case bellslash
  case sun
  case plus
  
  var description : String {
    switch self {
    case .circle: return "circle.inset.filled"
    case .moon: return "moon"
    case .bell: return "bell"   //"checkmark.seal.fill"
    case .bellslash: return "bell.slash"  // "xmark.seal" // "xmark.circle"
    case .sun: return "sun.max"
    case .plus: return "plus"
    }
  }
}


