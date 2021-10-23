//
//  TodoListContracts.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import Foundation

// MARK - Interactor



// MARK - Presenter

protocol TodoListPresenterProtocol{
    func load()
    func selectedTodo(at index : Int)
}

enum TodoListPresenterOutput{
    case updateTitle(String)
    case setLoading(Bool)
    //case showTodoList([])
}

// MARK - View


// MARK - Router


