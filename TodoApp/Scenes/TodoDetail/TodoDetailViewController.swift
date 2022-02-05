//
//  TodoDetailViewController.swift
//  TodoApp
//
//  Created by alican on 24.10.2021.
//

import UIKit

class TodoDetailViewController: UIViewController {

    @IBOutlet var customView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var todoDetailSearchBar: UISearchBar!
    @IBOutlet weak var addTodoDetailButton: UIButton!
    var addButton : FloatingButton!
    
    private var todoDetailList: [TodoDetailPresentation] = []
    var textField = UITextField()
    
    var searching = false
    var workItemReference : DispatchWorkItem? = nil
    
    var viewModel : TodoDetailListViewModelProtocol!{
        didSet{
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        
        setUIComponent()
        tableView.separatorStyle = .none
    }
            
    override func viewWillAppear(_ animated: Bool) {
        setSearchBar()
        setTheme()
        viewModel.load()
        tableView.reloadData()
        UINavigationController().setNavigationController(nav: navigationController!)
    }
}

extension TodoDetailViewController : TodoDetailListViewModelDelegate{
    func handleViewModelOutput(_ output: TodoDetailListViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showTodoDetailList(let todoDetailList):
            self.todoDetailList = todoDetailList
            tableView.reloadData()
        }
    }
    
    func navigate(to route: TodoDetailListViewRoute) {
        switch route {
        case .detail(let viewModel):
            let viewController = TodoExplanationBuilder.make(with: viewModel)
            show(viewController,sender: nil)
        }
    }
}

extension TodoDetailViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReservedStrings.TodoDetailCell.asString) as! TodoDetailCell
        let todoDetail = todoDetailList[indexPath.row]
        cell.detailLbl.text = todoDetail.explanation
        cell.detailTitleLbl.text = todoDetail.detailTitle
        cell.isCompletedLbl.image = todoDetail.isCompleted ? CustomImage.checkmark.withTintColor(.systemGreen) : CustomImage.xmark.withTintColor(.systemPink)
        cell.isCompletedLbl.tintColor = cell.isCompletedLbl.image == CustomImage.checkmark ? UIColor.green : UIColor.red
        cell.dateLbl.text = DateFormatter().convertDateToString(date: todoDetail.date)
        cell.avatarLbl.image = CustomImage.Image(tag: todoDetail.colorType)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if todoDetailList.count == 0 {
            tableView.setEmptyView(title: LocalizableStrings.emptyTableViewBaseMessage.description.localized(), message: LocalizableStrings.emptyTableViewChildMessage.description.localized(),messageImage: UIImage(systemName: "exclamationmark.bubble")!)
        }else{
            tableView.restore()
        }
        return todoDetailList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
  extension TodoDetailViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.editPage(id: todoDetailList[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: LocalizableStrings.delete.description.localized()) { (contextualAction, view, boolValue) in
            let todoDetail = self.todoDetailList[indexPath.row]
            LocalNotificationManager.cancelThisNotification(todoDetail.notificationId)
            self.viewModel.deleteTodoDetail(todoDetailId: self.todoDetailList[indexPath.row].id)
            self.todoDetailList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            //tableView.reloadData()
            boolValue(true)
           }
        deleteAction.backgroundColor = .systemPink
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])

        return swipeActions
    }
}

extension TodoDetailViewController : UISearchBarDelegate{
    // This code structure is designed to search when the enter button is pressed.
    /*
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        viewModel.searchTodoDetail(todoDetail: text)
        self.tableView.reloadData()
    }
     
    // If you press the x icon, the searchTextField was reset, and we were checking its element count and reloading the entire list.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            self.viewModel.load()
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
                self.searchtodoDetail(text: searchText)
            }
            
            workItemReference = workItem
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: workItem)
        }else{
            self.viewModel.load()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func searchtodoDetail(text : String){
        viewModel.searchTodoDetail(searchText: text)
        self.searching = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setSearchBar() {
        if let textfield = todoDetailSearchBar.value(forKey: "searchField") as? UITextField {
                        let atrString = NSAttributedString(string: LocalizableStrings.searchbarPlaceholder.description.localized(),
                                                           attributes: [.foregroundColor : UIColor.darkGray,
                                                                        .font : UIFont(name: "Chalkboard SE Bold", size: 15)])
                        textfield.attributedPlaceholder = atrString

       }
        todoDetailSearchBar[keyPath: \.searchTextField].font = UIFont(name: "Chalkboard SE Bold", size: 15)
    }
}

extension TodoDetailViewController{
    fileprivate func setUIComponent() {
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        let safeArea = view.safeAreaInsets.bottom
        addButton = FloatingButton(frame: CGRect().setBaseButtonPosition(screenWidth, screenHeight, safeArea))
        view.addSubview(addButton)
        addButton.customConfigure(with: CustomFloatingButtonViewModel.add)
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }
    
    @objc private func addButtonClicked(){
        viewModel.addPage(id: "")
    }
    
     func setTheme() {
        tableView.theme.backgroundColor = themed { $0.tableViewBackgroundColor }
        tableView.theme.tintColor = themed { $0.tableViewTintColor }
        todoDetailSearchBar.theme.backgroundColor = themed { $0.searchBarBackgroundColor }
        todoDetailSearchBar.theme.barTintColor = themed { $0.searchBarBarTintColor }
        todoDetailSearchBar.theme.tintColor = themed { $0.searchBarTintColor }
        customView.theme.backgroundColor = themed { $0.todoExplanationCustomViewThemeBackgroundColor }
    }
}
