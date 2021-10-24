//
//  TodoDetailPresentation.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import Foundation

struct TodoDetailPresentation: Equatable {
    let detailTitle: String
    let explanation : String
    let date : Date
}

extension TodoDetailPresentation{
    init(todoDetail : TodoDetail){
        self.init(detailTitle: todoDetail.title!, explanation: todoDetail.explation!, date: todoDetail.date!)
    }
}
