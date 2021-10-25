//
//  TodoDetailViewController.swift
//  TodoApp
//
//  Created by alican on 24.10.2021.
//

import UIKit

class TodoDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel : TodoDetailViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.load()
        // Do any additional setup after loading the view.
    }
}

extension TodoDetailViewController: TodoDetailViewModelDelegate{
    func showDetail(_ presentation: [TodoDetailPresentation]) {
        
    }
}

