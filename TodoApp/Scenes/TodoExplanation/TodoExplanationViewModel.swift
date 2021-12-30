//
//  TodoExplanationViewModel.swift
//  TodoApp
//
//  Created by alican on 25.10.2021.
//

import Foundation
import CoreData

final class TodoExplanationViewModel: TodoExplanationViewModelProtocol {
      
    weak var delegate: TodoExplanationViewModelDelegate?
    private let service : TodoDetailListServiceProtocol
    private let presentation: TodoExplanationPresentation
    private var todoDetail: TodoDetail = TodoDetail()
    private var todo : Todo = Todo()
    private let index : Int

    
    init(service : TodoDetailListServiceProtocol , todoDetail : TodoDetail, todo : Todo , index : Int) {
        self.service = service
        self.todoDetail = todoDetail
        self.index = index
        self.todo = todo
        self.presentation = TodoExplanationPresentation(todoDetail: self.todoDetail)
    }
    
    func load() {
        delegate?.showDetail(presentation)
    }
    
    func addTodoDetail(title : String , explanation : String , date : Date , iscCompleted : Bool , isTheNotificationScheduled : Bool) {
        todoDetail.title = title
        todoDetail.explation = explanation
        todoDetail.date = date
        todoDetail.isCompleted = iscCompleted
        todoDetail.isTheNotificationScheduled = isTheNotificationScheduled
        service.addTodoDetail(todoDetail: todoDetail, todo: todo)
    }
}
