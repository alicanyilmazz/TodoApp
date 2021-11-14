//
//  StringEnums.swift
//  TodoApp
//
//  Created by alican on 14.11.2021.
//

import Foundation

enum LocalizableStrings : CustomStringConvertible {
  case add
  case delete
  case cancel
  case edit
  case navigationbarTitle
  case searchbarPlaceHolder
  
  var description : String {
    switch self {
    case .add: return "UIAlertController.Add.Button"
    case .delete: return "UIAlertController.Delete.Button"
    case .edit: return "UIAlertController.Edit.Button"
    case .cancel: return "UIAlertController.Cancel.Button"
    case .navigationbarTitle: return "NavigationBar.Title"
    case .searchbarPlaceHolder: return "SearchBar.PlaceHolder"
    }
  }
}

enum ReservedStrings : String{
  case searchField
  case TodoListCell
  case TodoDetailCell
  
  var asString : String{
      return self.rawValue
  }
}


