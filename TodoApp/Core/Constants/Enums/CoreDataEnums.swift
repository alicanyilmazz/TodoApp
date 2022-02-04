//
//  CoreDataEnums.swift
//  TodoApp
//
//  Created by alican on 18.11.2021.
//

import Foundation

enum TodoDetailQuery : CustomStringConvertible {
  case matches
  case contains
  case matchesDetail
    
  var description : String {
    switch self {
    case .matches: return "parentTodo.id MATCHES %@"
    case .contains: return "title CONTAINS[cd] %@"
    case .matchesDetail: return "id MATCHES %@"
    }
  }
}

enum TodoDetailKey : CustomStringConvertible {
  case title
  case todoDetail
    
  var description : String {
    switch self {
    case .title: return "title"
    case .todoDetail: return "TodoDetail"
    }
  }
}

enum TodoQuery : CustomStringConvertible {
  case contains
    
  var description : String {
    switch self {
    case .contains: return "title CONTAINS[cd] %@"
    }
  }
}

enum TodoKeys : CustomStringConvertible {
  case title
  case todoDetail
    
  var description : String {
    switch self {
    case .title: return "title"
    case .todoDetail: return "TodoDetail"
    }
  }
}

enum CoreDataErrors : CustomStringConvertible {
  case contextError
  case fetchingDataError
    
  var description : String {
    switch self {
    case .contextError: return "Error saving context"
    case .fetchingDataError: return "Error fetching data from context"
    }
  }
}
