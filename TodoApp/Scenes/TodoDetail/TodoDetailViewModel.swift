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
    

    init(service : TodoDetailListServiceProtocol,todo : Todo){
        self.service = service
        self.todo = todo
    }
    
    func load() {
        notify(.updateTitle("TodoDetails"))
        notify(.setLoading(true))
        let result = service.fetchTodos(with: NSFetchRequest<TodoDetail>(entityName: "TodoDetail"), todo: todo, predicate: nil)
        if result != nil{
            self.todoDetails = result
            let presentation = result.map({TodoDetailPresentation(todoDetail: $0)})
            self.notify(.showTodoDetailList(presentation))
        }
    
    }
    
    func selectedTodoDetail(at index: Int) {
        <#code#>
    }
    
    func addTodoDetail(todoDetail: String) {
        <#code#>
    }
    
    func searchTodoDetail(todoDetail: String) {
        <#code#>
    }
    
    func deleteTodoDetail(index: Int) {
        <#code#>
    }
    
    func EditTodoDetail(index: Int, todoDetail: String) {
        <#code#>
    }
    
    private func notify(_ output: TodoDetailListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
