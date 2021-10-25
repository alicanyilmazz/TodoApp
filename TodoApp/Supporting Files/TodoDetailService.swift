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
  func fetchTodos(with request : NSFetchRequest<TodoDetail> ,todo : Todo , predicate: NSPredicate?) -> [TodoDetail]
  func save()
}

class TodoDetailListService : TodoDetailListServiceProtocol {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var data = [TodoDetail]()
    
    func fetchTodos(with request : NSFetchRequest<TodoDetail> = TodoDetail.fetchRequest() ,todo : Todo ,predicate: NSPredicate? = nil) -> [TodoDetail]{
        let predicate = NSPredicate(format: "parentTodo.title MATCHES %@" , todo.title!)
        do {
            data = try context.fetch(request)
        } catch  {
            print("Error fetching data from context \(error)")
        }
        return data
    }
    
    func save(){
        do {
           try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
}
