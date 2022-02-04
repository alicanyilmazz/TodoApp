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
  case searchbarPlaceholder
  case textfieldTodoTitle
  case textfieldTodoDetailTitle
  case textfieldTodoDetail
  case addPageTitle
  case addPageButtonTitle
  case snackbarOnMessage
  case snackbarOffMessage
  case emptyTableViewBaseMessage
  case emptyTableViewChildMessage
  case validationMessage3and25
  case validationMessage8and150
  case validationMessage3and40
  case validationOkMessage
  case todoAlertPageMessageTitle
  case todoAlertPageTitleTitle
  case cancelButtonTitle
  case saveButtonTitle
  case todoBaseTitle
  case todoChildTitle
  case notificationValidationMessage
  
  var description : String {
    switch self {
    case .add: return "UIAlertController.Add.Button"
    case .delete: return "UIAlertController.Delete.Button"
    case .edit: return "UIAlertController.Edit.Button"
    case .cancel: return "UIAlertController.Cancel.Button"
    case .navigationbarTitle: return "NavigationBar.Title"
    case .searchbarPlaceholder:return "UISearchBar.Search.Placeholder"
    case .textfieldTodoTitle:return "TodoAlertController.TextField.Placeholder.Message"
    case .textfieldTodoDetailTitle:return "TodoDetailController.TextField.Placeholder.Message"
    case .textfieldTodoDetail:return "TodoDetailController.TextField.Placeholder.Message"
    case .addPageTitle:return "TodoDetailController.Page.Title.Message"
    case .addPageButtonTitle:return "TodoDetailController.Page.Button.Message"
    case .snackbarOnMessage:return "TodoDetailController.Page.Snackbar.On.Message"
    case .snackbarOffMessage:return "TodoDetailController.Page.Snackbar.Off.Message"
    case .emptyTableViewBaseMessage:return "Todo.Title.UITableViewController.Empty.Base.Message"
    case .emptyTableViewChildMessage:return "Todo.Title.UITableViewController.Empty.Child.Message"
    case .validationMessage3and25:return "3and25ValidationMessage"
    case .validationMessage8and150:return "8and150ValidationMessage"
    case .validationMessage3and40:return "3and40ValidationMessage"
    case .validationOkMessage:return "validationOkMessage"
    case .todoAlertPageTitleTitle:return "todoAlertPage.Title.Title"
    case .todoAlertPageMessageTitle:return "todoAlertPage.Message.Title"
    case .cancelButtonTitle:return "cancelButtonTitle"
    case .saveButtonTitle:return "saveButtonTitle"
    case .todoBaseTitle:return "todoBaseTitle"
    case .todoChildTitle:return "todoChildTitle"
    case .notificationValidationMessage:return "notificationValidationMessage"
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

