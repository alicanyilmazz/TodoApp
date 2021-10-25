//
//  TodoDetailBuilder.swift
//  TodoApp
//
//  Created by alican on 24.10.2021.
//

import Foundation
import UIKit
import CoreData

final class TodoDetailBuilder {

    static func make(with todo : Todo) -> TodoDetailViewController {
        let service: TodoDetailListServiceProtocol = TodoDetailListService()
        let todoDetails = service.fetchTodos(with: NSFetchRequest<TodoDetail>(entityName: "TodoDetail"), todo: todo, predicate: nil)
        let viewModel : TodoDetailViewModel = TodoDetailViewModel(todoDetail: todoDetails)
        let storyboard = UIStoryboard(name: "TodoDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TodoDetailViewController") as! TodoDetailViewController
        viewController.viewModel = viewModel
        return viewController
    }
}

