//
//  TodoExplanationContracts.swift
//  TodoApp
//
//  Created by alican on 25.10.2021.
//

import Foundation

protocol TodoExplanationViewModelDelegate: class {
    func showDetail(_ presentation: TodoExplanationPresentation)
}

protocol TodoExplanationViewModelProtocol {
    var delegate: TodoExplanationViewModelDelegate? { get set }
    func load()
    func addTodoDetail(title : String , explanation : String , date : Date , iscCompleted : Bool)
}
