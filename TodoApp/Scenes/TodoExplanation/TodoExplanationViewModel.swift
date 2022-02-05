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
    private var presentation: TodoExplanationPresentation?
    private var todoDetail: TodoDetail?
    private var todoId : String?
    private var todoDetailId : String?
    private let operationType : operationTypes?

    
    init(service : TodoDetailListServiceProtocol , todoDetailId : String, todoId : String , operationType : operationTypes) {
        self.service = service
        self.todoId = todoId
        self.todoDetailId = todoDetailId
        self.operationType = operationType
    }
    
    func load() {
        if operationType == .edit{
            todoDetail = service.fetchTodoDetail(with: TodoDetail.fetchRequest(),todoDetailId: todoDetailId!, predicate: nil)
            self.presentation = TodoExplanationPresentation(todoDetail: todoDetail!)
            delegate?.showDetail(presentation!)
        }else if operationType == .add{
            self.presentation = TodoExplanationPresentation(detailTitle: "", explanation: "", date: Date(), isCompleted: true, notificationId: UUID().uuidString, isTheNotificationScheduled: false, colorType: 0, id: UUID().uuidString)
            delegate?.showDetail(presentation!)
        }
    }
    
    func insertData(title : String , explanation : String , date : Date , iscCompleted : Bool , isTheNotificationScheduled : Bool , colorType : Int) {
        if operationType == .edit{
            todoDetail?.title = title
            todoDetail?.explation = explanation
            todoDetail?.date = date
            todoDetail?.isCompleted = iscCompleted
            todoDetail?.isTheNotificationScheduled = isTheNotificationScheduled
            todoDetail?.colorType = Int16(colorType)
            todoDetail?.notificationId = presentation?.notificationId
            todoDetail?.id = presentation?.id
            service.editTodoDetail(todoDetail: todoDetail!)
        }else if operationType == .add{
            service.addTodoDetail(title: title, explanation: explanation, date: date, iscCompleted: iscCompleted, isTheNotificationScheduled: isTheNotificationScheduled, colorType: colorType, todoId: todoId!, notificationId: self.presentation!.notificationId, id: self.presentation!.id)
        }
    }
}
