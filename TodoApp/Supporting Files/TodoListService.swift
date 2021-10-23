//
//  TodoListService.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import Foundation
import CoreData

protocol TodoListServiceProtocol {
  func fetchTodos(with request : NSFetchRequest<Todo>) -> [Todo]
}

class TodoListService : TodoListServiceProtocol {
   
    func fetchTodos(with request : NSFetchRequest<Todo> = Todo.fetchRequest()) -> [Todo]{
        var data : [Todo]?
        do {
            data = try CoreDataService.getContext().fetch(request)
        } catch  {
            print("Error fetching data from context \(error)")
        }
        return data!
    }
}
