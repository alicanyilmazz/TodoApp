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
  func fetchTodoWithId(with request : NSFetchRequest<Todo> ,todoId : String ,predicate: NSPredicate?) -> Todo?
  func editTodo(todo : Todo)
  func addTodo(title: String , colorType : Int)
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
    
    func fetchTodoWithId(with request : NSFetchRequest<Todo> = Todo.fetchRequest() ,todoId : String ,predicate: NSPredicate? = nil) -> Todo?{
        let todoPredicate = NSPredicate(format: "id LIKE %@" , todoId)
        
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [todoPredicate , additionalPredicate]) 
        }else{
            request.predicate = todoPredicate
        }

        do {
            todoResult = try context.fetch(request)
        } catch  {
            print("\(CoreDataErrors.fetchingDataError) \(error)")
        }
        if(todoResult.count == 0){
            return nil
        }
        return todoResult[0]
    }
    
    func addTodo(title: String , colorType : Int){
        let newTodo = Todo(context: context)
        newTodo.id = UUID().uuidString
        newTodo.title = title
        newTodo.colorType = Int16(colorType)
        todoResult.append(newTodo)
        save()
    }
    
    func editTodo(todo : Todo){
        todoResult.append(todo)
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
