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
    var addButton : FloatingButton!
    var themeButton : FloatingButton!
    
    var searching = false
    var workItemReference : DispatchWorkItem? = nil

    var presenter : TodoListPresenterProtocol!
    private var todos : [TodoPresentation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load()
        setTheme()
        setUIComponent()
        //setCancelButton()
    }
         
    override func viewDidAppear(_ animated: Bool) {
        setSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UINavigationController().setNavigationController(nav: navigationController!)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ReservedStrings.TodoListCell.asString) as! TodoCell
        let todo = todos[indexPath.row]
        cell.todoTitleLbl.text = todo.title
        cell.avatarImage.image = UIImage().getSystemUIImage(systemName: ImageName.circle.description)
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: LocalizableStrings.delete.description.localized()) {  (contextualAction, view, boolValue) in
            self.presenter.deleteTodo(index: indexPath.row)
            self.todos.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            boolValue(true)
           }
        deleteAction.backgroundColor = .systemPink

        let editAction = UIContextualAction(style: .destructive, title: LocalizableStrings.edit.description.localized()) {  (contextualAction, view, boolValue) in

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
    // This code structure is designed to search when the enter button is pressed.
    /*
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        self.presenter.searchTodo(todo: text)
        self.tableView.reloadData()
    }
    
    // If you press the x icon, the searchTextField was reset, and we were checking its element count and reloading the entire list.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            self.presenter.load()
            self.tableView.reloadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    */
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            workItemReference?.cancel()
            
            let workItem = DispatchWorkItem{
                self.searchtodo(text: searchText)
            }
            
            workItemReference = workItem
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: workItem)
        }else{
            self.presenter.load()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func searchtodo(text : String){
        self.presenter.searchTodo(todo: text)
        self.searching = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // You can also use the cancel button if you want, but we currently use the x icon to end the search.
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.presenter.load()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // If you want to use cancel button for searchbar you must be active the code on line 28.
    fileprivate func setCancelButton() {
        todoSearchBar.showsCancelButton = true
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
    }
    
    func setSearchBar() {
        if #available(iOS 13.0, *) {
            todoSearchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: LocalizableStrings.searchbarPlaceHolder.description.localized(), attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        } else {
            if let searchField = todoSearchBar.value(forKey: ReservedStrings.searchField.asString) as? UITextField {
                searchField.attributedPlaceholder = NSAttributedString(string: LocalizableStrings.searchbarPlaceHolder.description.localized(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
            }
        }
    }
}

extension TodoListViewController{
    
    fileprivate func setUIComponent() {
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        let safeArea = view.safeAreaInsets.bottom
        addButton = FloatingButton(frame: CGRect().setBaseButtonPosition(screenWidth, screenHeight, safeArea))
        view.addSubview(addButton)
        themeButton = FloatingButton(frame: CGRect().setChildButtonPosition(screenWidth, screenHeight, safeArea))
        view.addSubview(themeButton)
        addButton.customConfigure(with: CustomFloatingButtonViewModel.add)
        themeButton.customConfigure(with: CustomFloatingButtonViewModel.settings)
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        themeButton.addTarget(self, action: #selector(changeThemeClicked), for: .touchUpInside)
    }
    
    @objc private func addButtonClicked(){
            let customUI = CustomUI(customUIAlertTextField: [.add], customUIAlertAction: [.add,.cancel])
            showBasicAlert(on: self, customUI: customUI, customUIAlertController: CustomUIAlertController.add) { _actionTypes, _textFieldStatusTypes, _uiTextFields in
                if(_actionTypes == actionTypes.add && _textFieldStatusTypes == textFieldStatusTypes.acceptable){
                    self.presenter.addTodo(todo: _uiTextFields[0].text!)
                    self.presenter.load()
                    self.tableView.reloadData()
                }
            }
    }
    
    @objc private func changeThemeClicked(){
       let type = themeService.type
        if type == .dark{
            themeService.switch(.light)
            setLigthModeIcon(themeButton)
        }else{
            themeService.switch(.dark)
            setDarkModeIcon(themeButton)
        }
    }
    
    fileprivate func setTheme() {
        tableView.theme.backgroundColor = themed { $0.tableViewBackgroundColor }
        tableView.theme.tintColor = themed { $0.tableViewTintColor }
        todoSearchBar.theme.backgroundColor = themed { $0.searchBarBackgroundColor }
        todoSearchBar.theme.barTintColor = themed { $0.searchBarBarTintColor }
        todoSearchBar.theme.tintColor = themed { $0.searchBarTintColor }
    }
}

