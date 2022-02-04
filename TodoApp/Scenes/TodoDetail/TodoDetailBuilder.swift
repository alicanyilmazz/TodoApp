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

    static func make(with viewModel: TodoDetailListViewModelProtocol) -> TodoDetailViewController {
        let storyboard = UIStoryboard(name: "TodoDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TodoDetailViewController") as! TodoDetailViewController
        viewController.viewModel = viewModel
        return viewController
    }
}

