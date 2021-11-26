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
  func fetchTodoDetails(with request : NSFetchRequest<TodoDetail> ,todoTitle : String , predicate: NSPredicate?) -> [TodoDetail]
  func fetchTodoDetails(with request : NSFetchRequest<TodoDetail>) -> [TodoDetail]
  func deleteTodoDetail(index : Int, todoDetailTitle : String)
  func returnTodoDetail() -> TodoDetail
  func addTodoDetail(todoDetail : TodoDetail, todo : Todo)
  func searchTodoDetail(todoDetail : String , todoTitle : String) -> [TodoDetail]
}

class TodoDetailListService : TodoDetailListServiceProtocol {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var data = [TodoDetail]()
    private var todoDetail : TodoDetail = TodoDetail()
    
    func fetchTodoDetails(with request : NSFetchRequest<TodoDetail> = TodoDetail.fetchRequest() ,todoTitle : String ,predicate: NSPredicate? = nil) -> [TodoDetail]{
        let detailPredicate = NSPredicate(format: TodoDetailQuery.matches.description , todoTitle)
        
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [detailPredicate , additionalPredicate])
        }else{
            request.predicate = detailPredicate
        }

        do {
            data = try context.fetch(request)
        } catch  {
            print("\(CoreDataErrors.fetchingDataError) \(error)")
        }
        return data
    }
    
    func fetchTodoDetails(with request : NSFetchRequest<TodoDetail> = TodoDetail.fetchRequest()) -> [TodoDetail]{
        do {
            data = try context.fetch(request)
        } catch  {
            print("\(CoreDataErrors.fetchingDataError) \(error)")
        }
        return data
    }
    
    func searchTodoDetail(todoDetail : String , todoTitle : String) -> [TodoDetail]{
        let request : NSFetchRequest<TodoDetail> = TodoDetail.fetchRequest()
        let predicate = NSPredicate(format: TodoDetailQuery.contains.description, todoDetail)
        request.sortDescriptors = [NSSortDescriptor(key: TodoDetailKey.title.description, ascending: true)]
        return fetchTodoDetails(with: request,todoTitle: todoTitle,predicate: predicate)
    }
    
    func addTodoDetail(todoDetail : TodoDetail, todo : Todo){
        todoDetail.parentTodo = todo
        data.append(todoDetail)
        save()
    }
    
    func returnTodoDetail() -> TodoDetail {
        let newTodoDetail = TodoDetail(context: context)
        return newTodoDetail
    }

    func deleteTodoDetail(index : Int, todoDetailTitle : String){
        let allTodoDetails = fetchTodoDetails(with: NSFetchRequest<TodoDetail>(entityName: TodoDetailKey.todoDetail.description), todoTitle: todoDetailTitle, predicate: nil)
        context.delete(allTodoDetails[index])
        save()
    }
    
    fileprivate func save(){
        do {
           try context.save()
        } catch {
            print("\(CoreDataErrors.contextError.description) \(error)")
        }
    }
}

