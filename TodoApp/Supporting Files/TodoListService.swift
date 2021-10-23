//
//  TodoListService.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import Foundation
import CoreData
import UIKit

protocol TodoListServiceProtocol {
  func fetchTodos(with request : NSFetchRequest<Todo>) -> [Todo]
  func addTodo(todo : String)
  func searchTodo(todo : String) -> [Todo]
}

class TodoListService : TodoListServiceProtocol {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var data = [Todo]()
    
    func fetchTodos(with request : NSFetchRequest<Todo> = Todo.fetchRequest()) -> [Todo]{
        do {
            data = try context.fetch(request)
        } catch  {
            print("Error fetching data from context \(error)")
        }
        return data
    }
    
    func addTodo(todo : String){
        let newTodo = Todo(context: CoreDataService.getContext())
        newTodo.title = todo
        data.append(newTodo)
        save()
    }
    
    func searchTodo(todo : String) -> [Todo]{
        let request : NSFetchRequest<Todo> = Todo.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", todo)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        return fetchTodos(with: request)
    }
    
    func save(){
        do {
           try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
}
