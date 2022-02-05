//
//  TodoListPresenter.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import Foundation

final class TodoListPresenter : TodoListPresenterProtocol{
    
    private unowned var view : TodoListViewProtocol
    private let interactor : TodoListInteractorProtocol
    private let router: TodoListRouterProtocol
    
    init(view: TodoListViewProtocol,interactor: TodoListInteractorProtocol,router: TodoListRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }
    
    func load() {
        view.handleOutput(.updateTitle("NavigationBar.Title".localized()))
        interactor.load()
    }
    
    func selectedTodo(id: String , title : String) {
        interactor.selectedTodo(id: id , title: title)
    }
    
    func searchTodo(todo: String) {
        interactor.searchTodo(todo: todo)
    }
    
    func deleteTodo(index: Int) {
        interactor.deleteTodo(index: index)
    }

    func removeNotifications(todo: String) {
        interactor.removeNotifications(todo: todo)
    }
    
    func addPage(at id : String) {
        interactor.addPage(at: id)
    }
    
    func editPage(at id : String) {
        interactor.editPage(at: id)
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
        case .showTodoDetail(let id , let title):
            router.navigate(to: .detailPage(id , title))
        case .showTodoAddOrUpdate(let todoId , let type):
            router.navigate(to: .TodoAddOrUpdate(todoId , type))
        }
    }
}
