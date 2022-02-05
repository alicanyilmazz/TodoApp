//
//  TodoListAlertPresenter.swift
//  TodoApp
//
//  Created by alican on 12.01.2022.
//

import Foundation
import CoreData

final class TodoListAlertPresenter : TodoListAlertPresenterProtocol{

    private unowned var view : TodoListAlertViewProtocol
    private let interactor : TodoListAlertInteractorProtocol
    private var operationType : operationTypes?
    
    init(view: TodoListAlertViewProtocol,interactor: TodoListAlertInteractorProtocol,todoId : String , operationType : operationTypes){
        self.view = view
        self.interactor = interactor
        self.interactor.delegate = self
        self.operationType = operationType
    }
    
    func load() {
        if operationType == .edit{
            view.handleOutput(.updateTitle("NavigationBar.Title".localized()))
            interactor.load()
        }else{
            view.handleOutput(.updateTitle(LocalizableStrings.todoBaseTitle.description.localized()))
            interactor.initialload()
        }
    }
    
    func Insert(title: String, colorType: Int) {
        if(operationType == .add){
            interactor.add(title: title, colorType: colorType)
        }else{
            interactor.edit(title: title, colorType: colorType)
        }
    }
}

extension TodoListAlertPresenter : TodoListAlertInteractorDelegate{
    func handleOutput(_ output: TodoListAlertInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showTodo(let todo):
            let todoAlertPresentation = TodoAlertPresentation(todo: todo)
            view.handleOutput(.showTodo(todoAlertPresentation))
            view.showTodo(todoAlertPresentation)
        case .showEmptyTodo:
            let todoAlertPresentation = TodoAlertPresentation(title: "", colorType: 0, id: "")
            view.handleOutput(.showTodo(todoAlertPresentation))
            view.showTodo(todoAlertPresentation)
        }
    }
}

