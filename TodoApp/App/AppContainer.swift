//
//  AppContainer.swift
//  TodoApp
//
//  Created by alican on 22.10.2021.
//

import Foundation
import CoreData

let app = AppContainer()

final class AppContainer {
    
    let router = AppRouter()
    let service = TodoListService()
}
