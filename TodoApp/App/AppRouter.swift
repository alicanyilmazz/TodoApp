//
//  AppRouter.swift
//  TodoApp
//
//  Created by alican on 22.10.2021.
//

import UIKit

final class AppRouter {
    
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start(scene: UIWindowScene? = nil) {
        let viewController = TodoListBuilder.make()
        //viewController.view.backgroundColor = .systemPink
        //viewController.title = "Replace Me"
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        if scene != nil{
            window.windowScene = scene
        }
        window.makeKeyAndVisible()
    }
}
