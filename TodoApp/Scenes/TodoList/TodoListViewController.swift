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
    }
        
    override func viewDidAppear(_ animated: Bool) {
        setSearchBar()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        UINavigationController().setNavigationController(nav: navigationController!, foregroundColor: .systemOrange, barTintColor: ColorPalette.darkBackground, tintColor: .systemOrange)
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
        let customUI = CustomUI(customUIAlertTextField: [.add], customUIAlertAction: [.add,.cancel])
        showBasicAlert(on: self, customUI: customUI, customUIAlertController: CustomUIAlertController.add) { _actionTypes, _textFieldStatusTypes, _uiTextFields in
            if(_actionTypes == actionTypes.add && _textFieldStatusTypes == textFieldStatusTypes.acceptable){
                self.presenter.addTodo(todo: _uiTextFields[0].text!)
                self.presenter.load()
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            self.presenter.deleteTodo(index: indexPath.row)
            self.todos.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            boolValue(true)
           }
        deleteAction.backgroundColor = .systemPink

        let editAction = UIContextualAction(style: .destructive, title: "Edit") {  (contextualAction, view, boolValue) in

            let customUI = CustomUI(customUIAlertTextField: [.edit], customUIAlertAction: [.edit,.cancel])
            showBasicAlert(on: self, customUI: customUI, customUIAlertController: CustomUIAlertController.edit) { _actionTypes, _textFieldStatusTypes, _uiTextFields in
                if(_actionTypes == actionTypes.edit && _textFieldStatusTypes == textFieldStatusTypes.acceptable){
                    self.presenter.EditTodo(index: indexPath.row,todo: _uiTextFields[0].text!)
                    self.presenter.load()
                    self.tableView.reloadData()
                }
            }
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
    
    func setSearchBar() {
        if #available(iOS 13.0, *) {
            todoSearchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search your todo", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        } else {
            if let searchField = todoSearchBar.value(forKey: "searchField") as? UITextField {
                searchField.attributedPlaceholder = NSAttributedString(string: "Search your todo", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
            }
        }
    }
}


extension UINavigationController{
    func setNavigationController(nav : UINavigationController , foregroundColor : UIColor, barTintColor : UIColor, tintColor : UIColor ){
        nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: foregroundColor]
        nav.navigationBar.barTintColor = barTintColor
        nav.navigationBar.tintColor = tintColor
    }
}
