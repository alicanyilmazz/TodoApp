//
//  TodoListInteractor.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import Foundation
import CoreData

final class TodoListInteractor : TodoListInteractorProtocol{

    var delegate : TodoListInteractorDelegate?
    
    private let service: TodoListServiceProtocol
    private var todos : [Todo] = []
    
    init(service: TodoListServiceProtocol){
        self.service = service
    }
    
    func load() {
        delegate?.handleOutput(.setLoading(true))
        todos = service.fetchTodos(with: NSFetchRequest<Todo>(entityName: "Todo"))
        delegate?.handleOutput(.setLoading(false))
        self.delegate?.handleOutput(.showTodoList(todos))
    }
    
    func selectedTodo(id: String , title: String) {
        //let todo = todos[index]
        //delegate?.handleOutput(.showTodoDetail(todo))
        delegate?.handleOutput(.showTodoDetail(id , title))
    }
    
    func searchTodo(todo: String) {
        todos = service.searchTodo(todo: todo)
        self.delegate?.handleOutput(.showTodoList(todos))
    }
    
    func deleteTodo(index: Int) {
        service.deleteTodo(index: index)
    }

    func addPage(at id : String) {
        self.delegate?.handleOutput(.showTodoAddOrUpdate(id , operationTypes.add))
    }
    
    func editPage(at id: String) {
        self.delegate?.handleOutput(.showTodoAddOrUpdate(id , operationTypes.edit))
    }
            
    func removeNotifications(todo: String) {
        var todoDetails = service.fetchTodoDetails(with: TodoDetail.fetchRequest(), todoTitle: todo, predicate: nil)
        if todoDetails.count != 0{
            var notificationIds : [String] = [String]()
            for todoDetail in todoDetails{
                notificationIds.append(todoDetail.notificationId!)
            }
            LocalNotificationManager.cancelThisNotifications(notificationIds)
        }
    }
}

