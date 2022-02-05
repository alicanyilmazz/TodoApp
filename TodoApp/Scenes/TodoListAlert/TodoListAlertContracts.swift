//
//  TodoListAlertContracts.swift
//  TodoApp
//
//  Created by alican on 12.01.2022.
//

import Foundation
import CoreData

// MARK - Interactor

protocol TodoListAlertInteractorProtocol : class {
    var delegate : TodoListAlertInteractorDelegate? {get set}
    func add(title : String , colorType : Int)
    func edit(title : String , colorType : Int)
    func load()
    func initialload()
}

enum TodoListAlertInteractorOutput : Equatable{
    case showTodo(Todo)
    case showEmptyTodo
    case setLoading(Bool)
}

protocol TodoListAlertInteractorDelegate : class{
    func handleOutput(_ output : TodoListAlertInteractorOutput)
}

// MARK - Presenter

protocol TodoListAlertPresenterProtocol : class {
    func load()
    func Insert(title : String , colorType : Int)
}

enum TodoListAlertPresenterOutput : Equatable{
    case updateTitle(String)
    case setLoading(Bool)
    case showTodo(TodoAlertPresentation)
}

// MARK - View

protocol TodoListAlertViewProtocol : class{
    func handleOutput(_ output: TodoListAlertPresenterOutput)
    func showTodo(_ presentation : TodoAlertPresentation)
}


