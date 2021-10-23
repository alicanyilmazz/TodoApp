//
//  TodoListPresenter.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import Foundation

final class TodoListPresenter : TodoListPresenterProtocol{
    private unowned let view : TodoListViewProtocol
    private let interactor : TodoListInteractorProtocol
    private let router: TodoListRouterProtocol
    
    init(view: TodoListViewProtocol,interactor: TodoListInteractorProtocol,router: TodoListRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }
    
    func load() {
        view.handleOutput(.updateTitle("Todos"))
        interactor.load()
    }
    
    func selectedTodo(at index: Int) {
        interactor.selectedTodo(at: index)
    }
    
    
}

extension TodoListPresenter : TodoListInteractorDelegate{
    func handleOutput(_ output: TodoListInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showTodoList(let todos):
            let todoPresentation = todos.map(TodoPresentation.init)
            view.handleOutput(.showTodoList(todoPresentation))
        case .showTodoDetail(let todo):
            router.navigate(to: .detail(todo))
        }
    }
}
