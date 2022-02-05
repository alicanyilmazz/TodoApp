//
//  TodoDetailViewModel.swift
//  TodoApp
//
//  Created by alican on 24.10.2021.
//

import Foundation
import CoreData

//case .matches: return "parentTodo.title MATCHES %@"
//case .contains: return "title CONTAINS[cd] %@"

final class TodoDetailViewModel: TodoDetailListViewModelProtocol {
    
    weak var delegate: TodoDetailListViewModelDelegate?
    private let service : TodoDetailListServiceProtocol
    private var todoDetails: [TodoDetail] = []
    private var todoId : String
    private var title : String
    private var todoDetail : TodoDetail = TodoDetail()

    init(service : TodoDetailListServiceProtocol,id : String , title : String){
        self.service = service
        self.todoId = id
        self.title = title
    }
    
    func load() {
        notify(.updateTitle(self.title.uppercased()))
        notify(.setLoading(true))
        let result = service.fetchTodoDetails(with: NSFetchRequest<TodoDetail>(entityName: "TodoDetail"), todoId: todoId, predicate: nil)
            self.todoDetails = result
            let presentation = result.map({TodoDetailPresentation(todoDetail: $0)})
            self.notify(.showTodoDetailList(presentation))
    }
    
    func editPage(id: String) {
        //let todoDetail = todoDetails[index]
        //let viewModel = TodoExplanationViewModel(service: service, todoDetail: todoDetail, todo: todo)
        //delegate?.navigate(to: .detail(viewModel))
        
        let viewModel = TodoExplanationViewModel(service: service, todoDetailId: id, todoId: todoId, operationType: .edit)
        delegate?.navigate(to: .detail(viewModel))
    }
    
    func addPage(id: String) {
        //var _todoDetail = service.returnTodoDetail()
        //let viewModel = TodoExplanationViewModel(service: service, todoDetail: _todoDetail, todo: todo)
        //delegate?.navigate(to: .detail(viewModel))
        
        let viewModel = TodoExplanationViewModel(service: service, todoDetailId: id, todoId: todoId, operationType: .add)
        delegate?.navigate(to: .detail(viewModel))
    }
   
    func searchTodoDetail(searchText: String) {
        var result = service.searchTodoDetail(searchText: searchText, id: self.todoId)
        let presentation = result.map({TodoDetailPresentation(todoDetail: $0)})
        self.notify(.showTodoDetailList(presentation))
    }
    
    func deleteTodoDetail(todoDetailId : String) {
        service.deleteTodoDetail(id: todoDetailId)
    }

    private func notify(_ output: TodoDetailListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
