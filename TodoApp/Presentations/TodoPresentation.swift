//
//  TodoPresentation.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import Foundation

final class TodoPresentation: NSObject {
    
    let title: String
    
    init(title: String) {
        self.title = title
        super.init()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? TodoPresentation else { return false }
        return self.title == other.title
    }
}

extension TodoPresentation {
    convenience init(todo: Todo) {
        self.init(title: todo.title!)
    }
}
