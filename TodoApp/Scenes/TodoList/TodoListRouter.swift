//
//  TodoListRouter.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import UIKit

final class TodoListRouter : TodoListRouterProtocol{
    
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: TodoListRoute) {
        switch route {
        case .detail(let todo):
            print("detail page routing")
            //let detailView = MovieDetailBuilder.make(with: movie)
            //view.show(detailView, sender: nil)
        }
    }
}
