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
    let isTheNotificationScheduled : Bool
    let colorType : Int
    let id : String
    
    init(detailTitle: String,explanation : String ,date : Date ,isCompleted : Bool , notificationId : String , isTheNotificationScheduled : Bool , colorType : Int , id : String){
        self.detailTitle = detailTitle
        self.explanation = explanation
        self.date = date
        self.isCompleted = isCompleted
        self.notificationId = notificationId
        self.isTheNotificationScheduled = isTheNotificationScheduled
        self.colorType = colorType
        self.id = id
        super.init()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? TodoExplanationPresentation else { return false }
        return self.detailTitle == other.detailTitle && self.explanation == other.explanation && self.date == other.date && self.isCompleted == other.isCompleted && self.isTheNotificationScheduled == other.isTheNotificationScheduled && self.colorType == other.colorType && self.id == other.id
    }
}

extension TodoExplanationPresentation{
    convenience init(todoDetail : TodoDetail){
        self.init(detailTitle: todoDetail.title! , explanation: todoDetail.explation! , date: todoDetail.date!, isCompleted: todoDetail.isCompleted,notificationId: todoDetail.notificationId!,isTheNotificationScheduled: todoDetail.isTheNotificationScheduled,colorType: Int(todoDetail.colorType),id: todoDetail.id!)
    }
}
