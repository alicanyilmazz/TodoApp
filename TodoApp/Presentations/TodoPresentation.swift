//
//  TodoPresentation.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import Foundation

final class TodoPresentation: NSObject {
    
    let title: String
    let colorType : Int
    let id : String
    
    init(title: String , colorType : Int , id : String) {
        self.title = title
        self.colorType = colorType
        self.id = id
        super.init()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? TodoPresentation else { return false }
        return self.title == other.title && self.colorType == other.colorType && self.id == other.id
    }
}

extension TodoPresentation {
    convenience init(todo: Todo) {
        self.init(title: todo.title!,colorType: Int(todo.colorType),id: todo.id!)
    }
}
