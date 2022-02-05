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
  func fetchTodoDetails(with request : NSFetchRequest<TodoDetail> ,todoId : String , predicate: NSPredicate?) -> [TodoDetail]
  func fetchTodoDetail(with request : NSFetchRequest<TodoDetail>,todoDetailId : String ,predicate: NSPredicate?) -> TodoDetail
  func fetchTodoDetails(with request : NSFetchRequest<TodoDetail>) -> [TodoDetail]
  func deleteTodoDetail(id : String)
  func addTodoDetail(title : String , explanation : String , date : Date , iscCompleted : Bool , isTheNotificationScheduled : Bool , colorType : Int , todoId : String , notificationId : String , id : String)
  func editTodoDetail(todoDetail : TodoDetail)
  func searchTodoDetail(searchText : String , id : String) -> [TodoDetail]
}

class TodoDetailListService : TodoDetailListServiceProtocol {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var todoDetails : [TodoDetail] = [TodoDetail]()
    private var todoDetail : TodoDetail = TodoDetail()
    private var todo : Todo?
    
    func fetchTodoDetails(with request : NSFetchRequest<TodoDetail> = TodoDetail.fetchRequest() ,todoId : String ,predicate: NSPredicate? = nil) -> [TodoDetail]{
        let detailPredicate = NSPredicate(format: TodoDetailQuery.matches.description , todoId)
        
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [detailPredicate , additionalPredicate])
        }else{
            request.predicate = detailPredicate
        }

        do {
            todoDetails = try context.fetch(request)
        } catch  {
            print("\(CoreDataErrors.fetchingDataError) \(error)")
        }
        return todoDetails
    }
    
    func fetchTodoDetail(with request : NSFetchRequest<TodoDetail> = TodoDetail.fetchRequest() ,todoDetailId : String ,predicate: NSPredicate? = nil) -> TodoDetail{
        let detailPredicate = NSPredicate(format: TodoDetailQuery.matchesDetail.description, todoDetailId)
        
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [detailPredicate , additionalPredicate])
        }else{
            request.predicate = detailPredicate
        }

        do {
            todoDetail = try context.fetch(request).first!
        } catch  {
            print("\(CoreDataErrors.fetchingDataError) \(error)")
        }
        return todoDetail
    }
    
    func fetchTodoDetails(with request : NSFetchRequest<TodoDetail> = TodoDetail.fetchRequest()) -> [TodoDetail]{
        do {
            todoDetails = try context.fetch(request)
        } catch  {
            print("\(CoreDataErrors.fetchingDataError) \(error)")
        }
        return todoDetails
    }
    
    func fetchTodoWithId(with request : NSFetchRequest<Todo> = Todo.fetchRequest() ,todoId : String ,predicate: NSPredicate? = nil) -> Todo?{
        let todoPredicate = NSPredicate(format: "id LIKE %@" , todoId)
        
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [todoPredicate , additionalPredicate])
        }else{
            request.predicate = todoPredicate
        }
        
        do {
            todo = try context.fetch(request).first
        } catch  {
            print("\(CoreDataErrors.fetchingDataError) \(error)")
        }
        
        return todo
    }
    
    func searchTodoDetail(searchText : String , id : String) -> [TodoDetail]{
        let request : NSFetchRequest<TodoDetail> = TodoDetail.fetchRequest()
        let predicate = NSPredicate(format: TodoDetailQuery.contains.description, searchText)
        request.sortDescriptors = [NSSortDescriptor(key: TodoDetailKey.title.description, ascending: true)]
        return fetchTodoDetails(with: request,todoId: id , predicate: predicate)
    }
    
    func addTodoDetail(title : String , explanation : String , date : Date , iscCompleted : Bool , isTheNotificationScheduled : Bool , colorType : Int , todoId : String , notificationId : String , id : String){
        let todo = fetchTodoWithId(todoId: todoId)
        
        todoDetail = TodoDetail(context: context)
        todoDetail.title = title
        todoDetail.explation = explanation
        todoDetail.date = date
        todoDetail.isCompleted = iscCompleted
        todoDetail.isTheNotificationScheduled = isTheNotificationScheduled
        todoDetail.colorType = Int16(colorType)
        todoDetail.notificationId = notificationId
        todoDetail.id = id
        
        todoDetail.parentTodo = todo
        todoDetails.append(todoDetail)
        save()
    }
    
    func editTodoDetail(todoDetail : TodoDetail){
        todoDetails.append(todoDetail)
        save()
    }
    
    func deleteTodoDetail( id : String){
        let request : NSFetchRequest<TodoDetail> = NSFetchRequest<TodoDetail>(entityName: TodoDetailKey.todoDetail.description)
        let allTodoDetail = fetchTodoDetail(todoDetailId: id)
        context.delete(allTodoDetail)
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


