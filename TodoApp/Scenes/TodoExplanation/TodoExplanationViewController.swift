//
//  TodoExplanationViewController.swift
//  TodoApp
//
//  Created by alican on 25.10.2021.
//

import UIKit
import Lottie

class TodoExplanationViewController: UIViewController {
    
    @IBOutlet var customView: UIView!
    
    @IBOutlet weak var animationView: AnimationView!
    
    @IBOutlet weak var todoExplanationTitleTextField: UITextField!
    
    @IBOutlet weak var todoExplanationTitleLbl: UILabel!
    
    @IBOutlet weak var todoExplanationDetailTextField: UITextField!
    
    @IBOutlet weak var todoExplanationDetailLbl: UILabel!
    
    @IBOutlet weak var todoExplanationDateTextField: UITextField!
    
    @IBOutlet weak var todoExplanationDateLbl: UILabel!
    
    @IBOutlet weak var todoExplanationCompletedSwitch: UISwitch!
    
    @IBOutlet weak var todoExplanationCompletedSwitchLbl: UILabel!
    
    @IBOutlet weak var todoExplanationSaveBtn: UIButton!
        
    var viewModel: TodoExplanationViewModelProtocol!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        todoExplanationDateTextField.delegate = self
        viewModel.delegate = self
        viewModel.load()
        setAnimation()
        setTheme()
        setUIComponent()
    }
}

extension TodoExplanationViewController: TodoExplanationViewModelDelegate {
    
    func showDetail(_ presentation: TodoExplanationPresentation) {
        todoExplanationTitleTextField.text = presentation.detailTitle
        todoExplanationDetailTextField.text = presentation.explanation
        todoExplanationDateTextField.text = DateFormatter().convertDateToString(date: presentation.date)
        todoExplanationCompletedSwitch.isOn = presentation.isCompleted
    }
}

extension TodoExplanationViewController{
    
    fileprivate func setTheme() {
        todoExplanationTitleTextField.theme.backgroundColor = themed { $0.todoExplanationTitleTextFieldBackgroundColor }
        todoExplanationTitleTextField.theme.textColor = themed { $0.todoExplanationTitleTextFieldTextColor }
        todoExplanationTitleLbl.theme.backgroundColor = themed { $0.todoExplanationTitleLblBackgroundColor }
        todoExplanationTitleLbl.theme.textColor = themed { $0.todoExplanationTitleLblTextColor }
        todoExplanationDetailTextField.theme.backgroundColor = themed { $0.todoExplanationDetailTextFieldBackgroundColor }
        todoExplanationDetailTextField.theme.textColor = themed { $0.todoExplanationDetailTextFieldTextColor }
        todoExplanationDetailLbl.theme.backgroundColor = themed { $0.todoExplanationDetailLblBackgroundColor }
        todoExplanationDetailLbl.theme.textColor = themed { $0.todoExplanationDetailLblTextColor }
        todoExplanationDateTextField.theme.backgroundColor = themed { $0.todoExplanationDateTextFieldBackgroundColor }
        todoExplanationDateTextField.theme.textColor = themed { $0.todoExplanationDateTextFieldTextColor }
        todoExplanationDateLbl.theme.backgroundColor = themed { $0.todoExplanationDateLblBackgroundColor }
        todoExplanationDateLbl.theme.textColor = themed { $0.todoExplanationDateLblTextColor }
        todoExplanationCompletedSwitch.theme.backgroundColor = themed { $0.todoExplanationCompletedSwitchLblBackgroundColor }
        todoExplanationCompletedSwitch.theme.onTintColor = themed { $0.todoExplanationCompletedSwitchOnTintColor }
        todoExplanationCompletedSwitch.theme.thumbTintColor = themed { $0.todoExplanationCompletedSwitchThumbTintColor }
        todoExplanationCompletedSwitchLbl.theme.textColor = themed { $0.todoExplanationCompletedSwitchLblTextColor }
        todoExplanationSaveBtn.theme.backgroundColor = themed { $0.todoExplanationSaveBtnBackgroundColor }
        todoExplanationSaveBtn.theme.tintColor = themed { $0.todoExplanationSaveBtnTextColor }
        customView.theme.backgroundColor = themed { $0.todoExplanationTitleLblBackgroundColor }
    }
    
    fileprivate func setAnimation() {
        animationView.backgroundColor = .clear
        animationView.loopMode = .loop
        animationView.play()
    }
    
    fileprivate func setUIComponent() {
        todoExplanationSaveBtn.layer.cornerRadius = 15
        todoExplanationSaveBtn.layer.borderWidth = 1
        todoExplanationSaveBtn.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        let date = DateFormatter().convertStringToDate(date: todoExplanationDateTextField.text)
        viewModel.addTodoDetail(title: todoExplanationTitleTextField.text!, explanation: todoExplanationDetailTextField.text!, date: date, iscCompleted: todoExplanationCompletedSwitch.isOn)
        LocalNotificationManager.setNotification(10, of: .seconds, repeats: false, title: "Your todo is ready", body: "Your must come true your todo.", userInfo: ["aps": ["hello":"world"]])
        _ = navigationController?.popViewController(animated: true)
    }
}

extension TodoExplanationViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIDatePicker().createDatePicker(_vc: self, textField: &todoExplanationDateTextField)
    }
    
    @objc func cancelButtonClick(){
        self.todoExplanationDateTextField.resignFirstResponder()
    }
   
    @objc func doneButtonClick(){
        if let dateAndTimePicker = self.todoExplanationDateTextField.inputView as? UIDatePicker{
            self.todoExplanationDateTextField.text = DateFormatter().convertDateToString(date: dateAndTimePicker.date)
        }
        self.todoExplanationDateTextField.resignFirstResponder()
    }
    
    @objc func datePickerHandler(datePicker : UIDatePicker){
        // You can use it to capture changes.
    }
}
