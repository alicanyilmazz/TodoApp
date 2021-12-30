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
  func fetchTodoDetails(with request : NSFetchRequest<TodoDetail>,todoTitle : String ,predicate: NSPredicate?) -> [TodoDetail]
  func addTodo(todo : String)
  func searchTodo(todo : String) -> [Todo]
  func deleteTodo(index : Int)
  func editTodo(index : Int,todo : String)
}

class TodoListService : TodoListServiceProtocol {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var todoResult = [Todo]()
    var todoDetailResult = [TodoDetail]()
    
    func fetchTodos(with request : NSFetchRequest<Todo> = Todo.fetchRequest()) -> [Todo]{
        do {
            todoResult = try context.fetch(request)
        } catch  {
            print("\(CoreDataErrors.fetchingDataError.description) \(error)")
        }
        return todoResult
    }
    
    func fetchTodoDetails(with request : NSFetchRequest<TodoDetail> = TodoDetail.fetchRequest() ,todoTitle : String ,predicate: NSPredicate? = nil) -> [TodoDetail]{
        let detailPredicate = NSPredicate(format: TodoDetailQuery.matches.description , todoTitle)
        
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [detailPredicate , additionalPredicate])
        }else{
            request.predicate = detailPredicate
        }

        do {
            todoDetailResult = try context.fetch(request)
        } catch  {
            print("\(CoreDataErrors.fetchingDataError) \(error)")
        }
        return todoDetailResult
    }
    
    func addTodo(todo : String){
        let newTodo = Todo(context: context)
        newTodo.title = todo
        todoResult.append(newTodo)
        save()
    }
        
    func searchTodo(todo : String) -> [Todo]{
        let request : NSFetchRequest<Todo> = Todo.fetchRequest()
        request.predicate = NSPredicate(format: TodoQuery.contains.description, todo)
        request.sortDescriptors = [NSSortDescriptor(key: TodoKeys.title.description, ascending: true)]
        return fetchTodos(with: request)
    }
    
    func deleteTodo(index : Int){
        let allTodos = fetchTodos()
        context.delete(allTodos[index])
        save()
    }
    
    func editTodo(index : Int,todo : String){
        let allTodos = fetchTodos()
        allTodos[index].setValue(todo, forKey: TodoKeys.title.description)
        save()
    }
    
    fileprivate func save(){
        do {
           try context.save()
        } catch {
            print("\(CoreDataErrors.contextError) \(error)")
        }
    }
}
