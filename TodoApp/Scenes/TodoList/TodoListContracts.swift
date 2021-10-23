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
    func selectedTodo(at index : Int)
    func addTodo(todo : String)
}

enum TodoListInteractorOutput{
    case setLoading(Bool)
    case showTodoList([Todo])
    case showTodoDetail(Todo)
}

protocol TodoListInteractorDelegate : class{
    func handleOutput(_ output : TodoListInteractorOutput)
}

// MARK - Presenter

protocol TodoListPresenterProtocol : class {
    func load()
    func selectedTodo(at index : Int)
    func addTodo(todo : String)
}

enum TodoListPresenterOutput{
    case updateTitle(String)
    case setLoading(Bool)
    case showTodoList([TodoPresentation])
}

// MARK - View

protocol TodoListViewProtocol : class{
    func handleOutput(_ output : TodoListPresenterOutput)
}


// MARK - Router

enum TodoListRoute{
    case detail(Todo)
}

protocol TodoListRouterProtocol : class{
    func navigate(to route: TodoListRoute)
}

