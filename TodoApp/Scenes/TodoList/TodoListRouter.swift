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
     var baseService : TodoListServiceProtocol!
     
     init(view: UIViewController) {
         self.view = view
     }

    func navigate(to route: TodoListRoute) {
        switch route {
        case .detailPage(let id , let title):
            service = TodoDetailListService()
            let todoDetailViewModel = TodoDetailViewModel(service: service, id: id , title: title)
            let detailView = TodoDetailBuilder.make(with: todoDetailViewModel )
            view.show(detailView, sender: nil)
        case .TodoAddOrUpdate(let id , let operationType):
            baseService = TodoListService()
            let todoAddOrUpdateView = TodoListAlertBuilder.make(with: id , service: baseService , operationType: operationType)
            view.show(todoAddOrUpdateView, sender: nil)
        }
    }
}
