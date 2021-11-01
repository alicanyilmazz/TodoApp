//
//  TodoListRouter.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import UIKit

final class TodoListRouter : TodoListRouterProtocol{

     unowned let view: UIViewController
     var service : TodoDetailListServiceProtocol!
     
     init(view: UIViewController) {
         self.view = view
     }

    func navigate(to route: TodoListRoute) {
        switch route {
        case .detail(let todo):
            service = TodoDetailListService()
            let todoDetailViewModel = TodoDetailViewModel(service: service, todo: todo)
            let detailView = TodoDetailBuilder.make(with: todoDetailViewModel, todo: todo)
            view.show(detailView, sender: nil)
        }
    }
}
