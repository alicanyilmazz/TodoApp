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
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        // Do any additional setup after loading the view.
    }
    
    func handleOutput(_ output: TodoListPresenterOutput) {
        switch output {
        case .updateTitle(let title):
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
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.selectedTodo(at: indexPath.row)
    }
    
    @IBAction func AddTodoButtonClicked(_ sender: UIButton) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo", message: "", preferredStyle: .alert)
        let actionAdd = UIAlertAction(title: "Add", style: .default) { (action) in
            // what will happed once the user clicks the Add Item button our UIAlert
            guard let _text = textField.text, !_text.isEmpty else {
                return
            }
            self.presenter.addTodo(todo: _text)
            self.presenter.load()
            self.tableView.reloadData()
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
                
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Todo :D"
            alertTextField.textColor = .systemPink
            textField = alertTextField
        }
        
        alert.addAction(actionAdd)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var textField = UITextField()
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            self.presenter.deleteTodo(index: indexPath.row)
            self.todos.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            boolValue(true)
           }
        deleteAction.backgroundColor = .systemPink
        
        let editAction = UIContextualAction(style: .destructive, title: "Edit") {  (contextualAction, view, boolValue) in

            let alert = UIAlertController(title: "Edit", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Save", style: .default) { (action) in

                guard let text = textField.text, !text.isEmpty else {
                    return
                }
                self.presenter.EditTodo(index: indexPath.row,todo: text)
                self.presenter.load()
                self.tableView.reloadData()
            }
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Edit item"
                alertTextField.textColor = .systemPink
                textField = alertTextField
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
            boolValue(true)
           }
        editAction.backgroundColor = .systemOrange
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction , editAction])

        return swipeActions
    }
}

extension TodoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        self.presenter.searchTodo(todo: text)
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            self.presenter.load()
            self.tableView.reloadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}


