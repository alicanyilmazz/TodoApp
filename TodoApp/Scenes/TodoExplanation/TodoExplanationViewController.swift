//
//  TodoExplanationViewController.swift
//  TodoApp
//
//  Created by alican on 25.10.2021.
//

import UIKit

class TodoExplanationViewController: UIViewController {

    
    @IBOutlet weak var todoExplanationImage: UIImageView!
    @IBOutlet weak var todoExplanationTitleLbl: UITextField!
    @IBOutlet weak var todoExplanationDetailLbl: UITextField!
    @IBOutlet weak var todoExplanationDateLbl: UITextField!
    @IBOutlet weak var todoExplanationCompletedSwitch: UISwitch!
    
    var viewModel: TodoExplanationViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.load()
        todoExplanationImage.image = UIImage(named: "ex")
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func switchChanged(_ sender: UISwitch) {
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        let date = "2016-04-14T10:44:00+0000"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateTime = dateFormatter.date(from:date)!
        viewModel.addTodoDetail(title: todoExplanationTitleLbl.text!, explanation: todoExplanationDetailLbl.text!, date: dateTime, iscCompleted: todoExplanationCompletedSwitch.isOn)
        _ = navigationController?.popViewController(animated: true)
    }
    
}

extension TodoExplanationViewController: TodoExplanationViewModelDelegate {
    
    func showDetail(_ presentation: TodoExplanationPresentation) {
        todoExplanationTitleLbl.text = presentation.detailTitle
        todoExplanationDetailLbl.text = presentation.explanation
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        var date = dateFormatter.string(from: presentation.date as Date)
        todoExplanationDateLbl.text = date
        todoExplanationCompletedSwitch.isOn = presentation.isCompleted
    }
}
