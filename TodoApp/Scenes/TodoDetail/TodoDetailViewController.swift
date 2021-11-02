//
//  TodoDetailViewController.swift
//  TodoApp
//
//  Created by alican on 24.10.2021.
//

import UIKit

class TodoDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var todoDetailSearchBar: UISearchBar!
    
    private var todoDetailList: [TodoDetailPresentation] = []
    var textField = UITextField()
    
    var viewModel : TodoDetailListViewModelProtocol!{
        didSet{
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        // Do any additional setup after loading the view.
    }
        
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            todoDetailSearchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search your todo", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
           } else {
               if let searchField = todoDetailSearchBar.value(forKey: "searchField") as? UITextField {
                   searchField.attributedPlaceholder = NSAttributedString(string: "Search your todo", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
               }
           }
        viewModel.load()
        tableView.reloadData()
    }
}

extension TodoDetailViewController : TodoDetailListViewModelDelegate{
    func handleViewModelOutput(_ output: TodoDetailListViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemOrange]
            navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1960784314, green: 0.2470588235, blue: 0.2941176471, alpha: 1)
            navigationController?.navigationBar.tintColor = .systemOrange
           // UINavigationBar.appearance().tintColor = UIColor.white
           // UINavigationBar.appearance().barTintColor = UIColor.magenta
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoDetailCell") as! TodoDetailCell
        let todoDetail = todoDetailList[indexPath.row]
        cell.detailLbl.text = todoDetail.explanation
        cell.detailTitleLbl.text = todoDetail.detailTitle
        cell.isCompletedLbl.image = todoDetail.isCompleted ? UIImage(systemName: "checkmark.seal.fill") : UIImage(systemName: "xmark.seal.fill")

        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm" // yyyy-MM-dd-HH-mm-ss
        var date = dateFormatter.string(from: todoDetail.date as Date)
        cell.dateLbl.text = date
        //cell.avatarLbl.image =UIImage(named: <#T##String#>)
        cell.avatarLbl.image = UIImage(systemName: "circle.inset.filled")?.withTintColor(UIColor.getRandomColor(),renderingMode: .alwaysOriginal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoDetailList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
  extension TodoDetailViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectedTodoDetail(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            self.viewModel.deleteTodoDetail(index: indexPath.row)
            self.todoDetailList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            //tableView.reloadData()
            boolValue(true)
           }
        deleteAction.backgroundColor = .systemPink
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])

        return swipeActions
    }

    @IBAction func addDetailButtonClicked(_ sender: UIButton) {
        viewModel.addTodoDetail()
    }
}

extension UIColor {
    class func randomColor(randomAlpha: Bool = false) -> UIColor {
        let redValue = CGFloat(arc4random_uniform(255)) / 255.0
        let greenValue = CGFloat(arc4random_uniform(255)) / 255.0
        let blueValue = CGFloat(arc4random_uniform(255)) / 255.0
        let alphaValue = randomAlpha ? CGFloat(arc4random_uniform(255)) / 255.0 : 1

        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
    }
    
    class func getRandomColor() -> UIColor {
        let arrColors = [#colorLiteral(red: 0.1254901961, green: 0.3882352941, blue: 0.6078431373, alpha: 1), #colorLiteral(red: 0.2352941176, green: 0.6823529412, blue: 0.6392156863, alpha: 1), #colorLiteral(red: 0.9647058824, green: 0.8352941176, blue: 0.3607843137, alpha: 1), #colorLiteral(red: 0.9294117647, green: 0.3333333333, blue: 0.231372549, alpha: 1), #colorLiteral(red: 1, green: 0.6470588235, blue: 0, alpha: 1), #colorLiteral(red: 0.8745098039, green: 0.9019607843, blue: 0.4039215686, alpha: 1), #colorLiteral(red: 0.4941176471, green: 0.6392156863, blue: 0.06274509804, alpha: 1), #colorLiteral(red: 0.9176470588, green: 0.8862745098, blue: 0.7176470588, alpha: 1), #colorLiteral(red: 0.9529411765, green: 0.7764705882, blue: 0.4666666667, alpha: 1), #colorLiteral(red: 0.7019607843, green: 0.2470588235, blue: 0.3843137255, alpha: 1), #colorLiteral(red: 0.9764705882, green: 0.337254902, blue: 0.3098039216, alpha: 1)]
        return arrColors.randomElement()!
    }
}
