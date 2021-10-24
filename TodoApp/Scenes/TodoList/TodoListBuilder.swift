//
//  TodoListBuilder.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import UIKit

final class TodoListBuilder {
    
    static func make() -> TodoListViewController {
        let storyboard = UIStoryboard(name: "TodoList", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "TodoListViewController") as! TodoListViewController
        let router = TodoListRouter(view: view)
        let interactor = TodoListInteractor(service: app.service)
        let presenter = TodoListPresenter(view: view,interactor: interactor,router: router)
        view.presenter = presenter
        return view
    }
}
