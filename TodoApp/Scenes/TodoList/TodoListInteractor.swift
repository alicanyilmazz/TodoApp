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
    
    func selectedTodo(at index: Int) {
        let todo = todos[index]
        delegate?.handleOutput(.showTodoDetail(todo))
    }
    
    func addTodo(todo : String) {
        service.addTodo(todo: todo)
    }
    
    func searchTodo(todo: String) {
        todos = service.searchTodo(todo: todo)
        self.delegate?.handleOutput(.showTodoList(todos))
    }
    
}
