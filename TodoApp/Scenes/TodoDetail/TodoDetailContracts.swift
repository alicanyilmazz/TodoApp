//
//  TodoDetailContracts.swift
//  TodoApp
//
//  Created by alican on 24.10.2021.
//

import Foundation

protocol TodoDetailListViewModelProtocol {
    var delegate: TodoDetailListViewModelDelegate? { get set }
    func load()
    func selectedTodoDetail(at index : Int)
    func searchTodoDetail(todoDetail : String)
    func deleteTodoDetail(index : Int)
    func addTodoDetail()
}

enum TodoDetailListViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showTodoDetailList([TodoDetailPresentation])
}

enum TodoDetailListViewRoute {
    case detail(TodoExplanationViewModelProtocol)
}

protocol TodoDetailListViewModelDelegate: class {
    func handleViewModelOutput(_ output: TodoDetailListViewModelOutput)
    func navigate(to route: TodoDetailListViewRoute)
}
