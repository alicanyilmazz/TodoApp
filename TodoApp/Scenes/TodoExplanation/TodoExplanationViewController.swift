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
        todoExplanationDateLbl.delegate = self
        viewModel.delegate = self
        viewModel.load()
        setUIComponents()
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        let date = DateFormatter().convertStringToDate(date: todoExplanationDateLbl.text)
        viewModel.addTodoDetail(title: todoExplanationTitleLbl.text!, explanation: todoExplanationDetailLbl.text!, date: date, iscCompleted: todoExplanationCompletedSwitch.isOn)
        _ = navigationController?.popViewController(animated: true)
    }
}

extension TodoExplanationViewController: TodoExplanationViewModelDelegate {
    
    func showDetail(_ presentation: TodoExplanationPresentation) {
        todoExplanationTitleLbl.text = presentation.detailTitle
        todoExplanationDetailLbl.text = presentation.explanation
        todoExplanationDateLbl.text = DateFormatter().convertDateToString(date: presentation.date)
        todoExplanationCompletedSwitch.isOn = presentation.isCompleted
    }
}

extension TodoExplanationViewController{
    func setUIComponents() {
        todoExplanationImage.image = UIImage(named: "ex")
        todoExplanationCompletedSwitch.onTintColor = #colorLiteral(red: 0.9956704974, green: 0.6578197479, blue: 0.2000168562, alpha: 1)
        todoExplanationCompletedSwitch.thumbTintColor = #colorLiteral(red: 0.1215686275, green: 0.1607843137, blue: 0.2, alpha: 1)
    }
}

extension TodoExplanationViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIDatePicker().createDatePicker(_vc: self, textField: &todoExplanationDateLbl)
    }
    
    @objc func cancelButtonClick(){
        self.todoExplanationDateLbl.resignFirstResponder()
    }
   
    @objc func doneButtonClick(){
        if let dateAndTimePicker = self.todoExplanationDateLbl.inputView as? UIDatePicker{
            self.todoExplanationDateLbl.text = DateFormatter().convertDateToString(date: dateAndTimePicker.date)
        }
        self.todoExplanationDateLbl.resignFirstResponder()
    }
    
    @objc func datePickerHandler(datePicker : UIDatePicker){
        // You can use it to capture changes.
    }
}
