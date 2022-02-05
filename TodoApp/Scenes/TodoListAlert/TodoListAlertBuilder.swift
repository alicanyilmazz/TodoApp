//
//  TodoListAlertBuilder.swift
//  TodoApp
//
//  Created by alican on 12.01.2022.
//

import Foundation
import UIKit
import CoreData

final class TodoListAlertBuilder {
    
    static func make(with id : String , service : TodoListServiceProtocol , operationType : operationTypes) -> TodoListAlertViewController {
        let storyboard = UIStoryboard(name: "TodoListAlert", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "TodoListAlertViewController") as! TodoListAlertViewController
        //let router = TodoListAlertRouter(view: view)
        let interactor = TodoListAlertInteractor(todoId: id, service: service , operationType: operationType)
        let presenter = TodoListAlertPresenter(view: view,interactor: interactor,todoId: id , operationType: operationType)
        view.presenter = presenter
        return view
    }
}
