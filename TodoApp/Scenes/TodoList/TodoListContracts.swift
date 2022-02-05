//
//  TodoListContracts.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import Foundation
import CoreData

// MARK - Interactor

protocol TodoListInteractorProtocol : class {
    var delegate : TodoListInteractorDelegate? {get set}
    func load()
    func selectedTodo(id : String , title : String)
    func searchTodo(todo : String)
    func deleteTodo(index : Int)
    func removeNotifications(todo : String)
    func addPage(at id : String)
    func editPage(at id : String)
}

enum TodoListInteractorOutput{
    case setLoading(Bool)
    case showTodoList([Todo])
    case showTodoDetail(String , String)
    case showTodoAddOrUpdate(String , operationTypes)
}

protocol TodoListInteractorDelegate : class{
    func handleOutput(_ output : TodoListInteractorOutput)
}

// MARK - Presenter

protocol TodoListPresenterProtocol : class {
    func load()
    func selectedTodo(id : String , title : String)
    func searchTodo(todo : String)
    func deleteTodo(index : Int)
    func removeNotifications(todo : String)
    func addPage(at id : String)
    func editPage(at id : String)
}

enum TodoListPresenterOutput{
    case updateTitle(String)
    case setLoading(Bool)
    case showTodoList([TodoPresentation])
    case showTodoAddOrUpdate(String , operationTypes)
}

// MARK - View

protocol TodoListViewProtocol : class{
    func handleOutput(_ output : TodoListPresenterOutput)
}


// MARK - Router

enum TodoListRoute{
    case detailPage(String , String)
    case TodoAddOrUpdate(String , operationTypes)
}

protocol TodoListRouterProtocol : class{
    func navigate(to route: TodoListRoute)
}

