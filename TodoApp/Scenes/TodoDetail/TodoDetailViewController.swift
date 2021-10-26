//
//  TodoDetailViewController.swift
//  TodoApp
//
//  Created by alican on 24.10.2021.
//

import UIKit

class TodoDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var todoDetailList: [TodoDetailPresentation] = []
    
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
        case .detail(let todoExplanationViewModelProtocol):
            print("this is not completed.")
        }
    }
}

extension TodoDetailViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoDetailCell") as! TodoDetailCell
        let todoDetail = todoDetailList[indexPath.row]
        cell.detailLbl.text = todoDetail.detailTitle
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        var date = dateFormatter.string(from: todoDetail.date as Date)
        cell.dateLbl.text = date
        //cell.avatarLbl.image =UIImage(named: <#T##String#>)
        cell.avatarLbl.image = UIImage(systemName: "paperplane")
        cell.avatarLbl.image?.withTintColor(UIColor.randomColor())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoDetailList.count
    }
}


extension TodoDetailViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // TODO
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
}
