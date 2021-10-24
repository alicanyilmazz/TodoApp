//
//  TodoDetailContracts.swift
//  TodoApp
//
//  Created by alican on 24.10.2021.
//

import Foundation

protocol TodoDetailViewModelDelegate: class {
    func showDetail(_ presentation: TodoDetailPresentation)
}

protocol TodoDetailViewModelProtocol {
    var delegate: TodoDetailViewModelDelegate? { get set }
    func load()
}
