//
//  TodoExplanationBuilder.swift
//  TodoApp
//
//  Created by alican on 25.10.2021.
//

import Foundation
import UIKit

final class TodoExplanationBuilder {
    
    static func make(with viewModel: TodoExplanationViewModelProtocol) -> TodoExplanationViewController {
        let storyboard = UIStoryboard(name: "TodoExplanation", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TodoExplanationViewController") as! TodoExplanationViewController
        viewController.viewModel = viewModel
        return viewController
    }
}
