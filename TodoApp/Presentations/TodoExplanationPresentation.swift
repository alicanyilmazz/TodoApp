//
//  TodoExplanationPresentation.swift
//  TodoApp
//
//  Created by alican on 25.10.2021.
//

import Foundation

final class TodoExplanationPresentation: NSObject {
    let detailTitle: String
    let explanation : String
    let date : Date
    let isCompleted : Bool
    let notificationId : String
    
    init(detailTitle: String,explanation : String ,date : Date ,isCompleted : Bool , notificationId : String){
        self.detailTitle = detailTitle
        self.explanation = explanation
        self.date = date
        self.isCompleted = isCompleted
        self.notificationId = notificationId
        super.init()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? TodoExplanationPresentation else { return false }
        return self.detailTitle == other.detailTitle && self.explanation == other.explanation && self.date == other.date && self.isCompleted == other.isCompleted
    }
}

extension TodoExplanationPresentation{
    convenience init(todoDetail : TodoDetail){
        self.init(detailTitle: todoDetail.title!, explanation: todoDetail.explation!, date: todoDetail.date!, isCompleted: todoDetail.isCompleted,notificationId: todoDetail.notificationId!)
    }
}
