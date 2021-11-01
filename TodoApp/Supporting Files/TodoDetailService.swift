//
//  TodoDetailService.swift
//  TodoApp
//
//  Created by alican on 25.10.2021.
//


import Foundation
import CoreData
import UIKit

protocol TodoDetailListServiceProtocol {
  func fetchTodoDetails(with request : NSFetchRequest<TodoDetail> ,todo : Todo , predicate: NSPredicate?) -> [TodoDetail]
  func fetchTodoDetails(with request : NSFetchRequest<TodoDetail>) -> [TodoDetail]
  func save()
  func deleteTodoDetail(index : Int, todo : Todo)
  func returnTodoDetail() -> TodoDetail
  func addTodoDetail(todoDetail : TodoDetail, todo : Todo)
}

class TodoDetailListService : TodoDetailListServiceProtocol {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var data = [TodoDetail]()
    private var todoDetail : TodoDetail = TodoDetail()
    
    func fetchTodoDetails(with request : NSFetchRequest<TodoDetail> = TodoDetail.fetchRequest() ,todo : Todo ,predicate: NSPredicate? = nil) -> [TodoDetail]{
        let predicate = NSPredicate(format: "parentTodo.title MATCHES %@" , todo.title!)
        request.predicate = predicate
        do {
            data = try context.fetch(request)
        } catch  {
            print("Error fetching data from context \(error)")
        }
        return data
    }
    
    func fetchTodoDetails(with request : NSFetchRequest<TodoDetail> = TodoDetail.fetchRequest()) -> [TodoDetail]{
        do {
            data = try context.fetch(request)
        } catch  {
            print("Error fetching data from context \(error)")
        }
        return data
    }
    
    func addTodoDetail(todoDetail : TodoDetail, todo : Todo){
        todoDetail.parentTodo = todo
        data.append(todoDetail)
        save()
    }
    
    func returnTodoDetail() -> TodoDetail {
        let newTodoDetail = TodoDetail(context: CoreDataService.getContext())
        return newTodoDetail
    }

    func deleteTodoDetail(index : Int, todo : Todo){
        let allTodoDetails = fetchTodoDetails(with: NSFetchRequest<TodoDetail>(entityName: "TodoDetail"), todo: todo, predicate: nil)
        context.delete(allTodoDetails[index])
        save()
    }

    func save(){
        do {
           try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
}

