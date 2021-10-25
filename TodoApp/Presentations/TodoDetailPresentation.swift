//
//  TodoDetailPresentation.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import Foundation

final class TodoDetailPresentation: NSObject {
    let detailTitle: String
    let explanation : String
    let date : Date
    
    init(detailTitle: String,explanation : String ,date : Date ){
        self.detailTitle = detailTitle
        self.explanation = explanation
        self.date = date
        super.init()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? TodoDetailPresentation else { return false }
        return self.detailTitle == other.detailTitle && self.explanation == other.explanation && self.date == other.date
    }
}

extension TodoDetailPresentation{
    convenience init(todoDetail : TodoDetail){
        self.init(detailTitle: todoDetail.title!, explanation: todoDetail.explation!, date: todoDetail.date!)
    }
}
