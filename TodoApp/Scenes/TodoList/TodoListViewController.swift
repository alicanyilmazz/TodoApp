//
//  TodoListViewController.swift
//  TodoApp
//
//  Created by alican on 23.10.2021.
//

import UIKit

class TodoListViewController: UIViewController , TodoListViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var todoSearchBar: UISearchBar!
    
    var presenter : TodoListPresenterProtocol!
    private var todos : [TodoPresentation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load()
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            todoSearchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search your todo", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
           } else {
               if let searchField = todoSearchBar.value(forKey: "searchField") as? UITextField {
                   searchField.attributedPlaceholder = NSAttributedString(string: "Search your todo", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
               }
           }
    }
    
    func handleOutput(_ output: TodoListPresenterOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemOrange]
            navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1960784314, green: 0.2470588235, blue: 0.2941176471, alpha: 1)
            navigationController?.navigationBar.tintColor = .systemOrange
        case .setLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showTodoList(let todos):
            self.todos = todos
        }
    }
}


extension TodoListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        //cell.textLabel?.text = todo.title
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell") as! TodoCell
        let todo = todos[indexPath.row]
        cell.todoTitleLbl.text = todo.title
        cell.avatarImage.image =  UIImage(systemName: "circle.inset.filled")?.withTintColor(UIColor.getRandomColor(),renderingMode: .alwaysOriginal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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

            let attributedString = NSAttributedString(string: "Edit", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1)])
            let MessageString = NSAttributedString(string: "Please enter your todo title.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1)])
            
            let alert = UIAlertController(title: "Edit", message: "Please enter your todo title.", preferredStyle: .alert)
            alert.setValue(attributedString, forKey: "attributedTitle")
            alert.setValue(MessageString, forKey: "attributedMessage")
            
            let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
            subview.layer.cornerRadius = 0
            subview.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.2470588235, blue: 0.2941176471, alpha: 1)
            subview.tintColor = .yellow
            // #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            //let dismissAction = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
            let actionSave = UIAlertAction(title: "Save", style: .default) { (action) in

                guard let text = textField.text, !text.isEmpty else {
                    return
                }
                self.presenter.EditTodo(index: indexPath.row,todo: text)
                self.presenter.load()
                self.tableView.reloadData()
            }
            actionSave.setValue(#colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1), forKey: "titleTextColor")
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Edit item"
                alertTextField.textColor = #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1)
                alertTextField.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.1607843137, blue: 0.2, alpha: 1)
                alertTextField.attributedPlaceholder = NSAttributedString(string: "Enter your todo title.",attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1)])
                alertTextField.tintColor = .orange
                alertTextField.borderStyle = .roundedRect
                let container = alertTextField.superview
                let effectView = container?.superview?.subviews[0]
                container?.backgroundColor = .clear
                effectView?.removeFromSuperview()
                //alertTextField.background = UIImage(systemName: "bell")
                
                textField = alertTextField
            }
            let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            actionCancel.setValue( #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1), forKey: "titleTextColor")
            
            alert.addAction(actionSave)
            alert.addAction(actionCancel)
            //alert.addAction(dismissAction)
            
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



