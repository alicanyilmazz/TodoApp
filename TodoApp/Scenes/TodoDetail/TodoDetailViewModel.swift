//
//  TodoDetailViewModel.swift
//  TodoApp
//
//  Created by alican on 24.10.2021.
//

import Foundation
import CoreData

final class TodoDetailViewModel: TodoDetailViewModelProtocol {
    
    weak var delegate: TodoDetailViewModelDelegate?
    private let presentation: TodoDetailPresentation
    
    init(todoDetail : TodoDetail) {
        self.presentation = TodoDetailPresentation(todoDetail: todoDetail)
    }
    
    func load() {
        delegate?.showDetail(presentation)
    }
}
