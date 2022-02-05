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
    func editPage(id : String)
    func addPage(id : String)
    func searchTodoDetail(searchText : String)
    func deleteTodoDetail(todoDetailId : String)
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
