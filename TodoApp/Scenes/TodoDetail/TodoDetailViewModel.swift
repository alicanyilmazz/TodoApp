//
//  TodoDetailViewModel.swift
//  TodoApp
//
//  Created by alican on 24.10.2021.
//

import Foundation
import CoreData

final class TodoDetailViewModel: TodoDetailListViewModelProtocol {
    
    weak var delegate: TodoDetailListViewModelDelegate?
    private let service : TodoDetailListServiceProtocol
    private var todoDetails: [TodoDetail] = []
    private var todo : Todo
    private var todoDetail : TodoDetail = TodoDetail()

    init(service : TodoDetailListServiceProtocol,todo : Todo){
        self.service = service
        self.todo = todo
    }
    
    func load() {
        notify(.updateTitle(todo.title?.uppercased() ?? "TodoDetails"))
        notify(.setLoading(true))
        let result = service.fetchTodoDetails(with: NSFetchRequest<TodoDetail>(entityName: "TodoDetail"), todoTitle: todo.title!, predicate: nil)
        if result != nil{
            self.todoDetails = result
            let presentation = result.map({TodoDetailPresentation(todoDetail: $0)})
            self.notify(.showTodoDetailList(presentation))
        }
    }
    
    func selectedTodoDetail(at index: Int) {
        let todoDetail = todoDetails[index]
        let viewModel = TodoExplanationViewModel(service: service, todoDetail: todoDetail, todo: todo, index: index)
        delegate?.navigate(to: .detail(viewModel))
    }
   
    func searchTodoDetail(todoDetail: String) {
        var result = service.searchTodoDetail(todoDetail: todoDetail, todoTitle: todo.title!)
        let presentation = result.map({TodoDetailPresentation(todoDetail: $0)})
        self.notify(.showTodoDetailList(presentation))
    }
    
    func deleteTodoDetail(index: Int) {
        service.deleteTodoDetail(index: index, todoDetailTitle: todo.title!)
    }
    
    func addTodoDetail() {
        var _todoDetail = service.returnTodoDetail()
        let viewModel = TodoExplanationViewModel(service: service, todoDetail: _todoDetail, todo: todo, index: 0)
        delegate?.navigate(to: .detail(viewModel))
    }
    
    private func notify(_ output: TodoDetailListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
