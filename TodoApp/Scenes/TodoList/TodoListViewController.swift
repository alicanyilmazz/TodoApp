//
//  TodoListViewController.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import UIKit

class TodoListViewController: UIViewController , TodoListViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter : TodoListPresenterProtocol!
    private var todos : [TodoPresentation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load()
        // Do any additional setup after loading the view.
    }
    
    func handleOutput(_ output: TodoListPresenterOutput) {
        switch output {
        case .updateTitle(let string):
            self.title = title
        case .setLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showTodoList(let todos):
            self.todos = todos
        }
    }
}


extension TodoListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
}

extension TodoListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}
