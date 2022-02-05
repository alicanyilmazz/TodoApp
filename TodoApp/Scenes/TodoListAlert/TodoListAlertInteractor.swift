//
//  TodoListAlertInteractor.swift
//  TodoApp
//
//  Created by alican on 12.01.2022.
//

import Foundation
import CoreData


final class TodoListAlertInteractor : TodoListAlertInteractorProtocol{

    var delegate : TodoListAlertInteractorDelegate?
    
    private let service: TodoListServiceProtocol
    private var todoId : String?
    private var todo : Todo?
    private var operationType : operationTypes?
    
    init(todoId : String? , service : TodoListServiceProtocol , operationType : operationTypes){
        self.service = service
        self.todoId = todoId
        self.operationType = operationType
    }

    func load() {
       //delegate?.handleOutput(.setLoading(true))
       todo = service.fetchTodoWithId(with: NSFetchRequest<Todo>(entityName: "Todo"), todoId: todoId!, predicate: nil)
       //delegate?.handleOutput(.setLoading(false))
       self.delegate?.handleOutput(.showTodo(todo!))
        
    /*
       if(todo != nil){
           self.delegate?.handleOutput(.showTodo(todo!))
       }else{
           self.delegate?.handleOutput(.showEmptyTodo)
       }
    */
    }
    
    func initialload() {
        self.delegate?.handleOutput(.showEmptyTodo)
    }
    
    func edit(title: String , colorType : Int) {
        self.todo?.title = title
        self.todo?.colorType = Int16(colorType)
        service.editTodo(todo: todo!)
    }
    
    func add(title: String , colorType : Int) {
        service.addTodo(title: title, colorType: colorType)
    }
}

