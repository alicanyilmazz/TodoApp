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
    
    private var notificationDate : DateComponents!
    
    @IBOutlet weak var titleValidationLabel: UILabel!
    
    @IBOutlet weak var detailValidationLabel: UILabel!
    
    var snackbarViewModel : SnackbarViewModel!
        
    var viewModel: TodoExplanationViewModelProtocol!
    
    let titleValidityType : String.ValidityType = .between3to25
    let detailValidityType : String.ValidityType = .between8to42
    
    var notificationId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoExplanationDateTextField.delegate = self
        viewModel.delegate = self
        viewModel.load()
        setAnimation()
        setTheme()
        setUIComponent()
        setInitialValues()
    }
}

extension TodoExplanationViewController: TodoExplanationViewModelDelegate {
    
    func showDetail(_ presentation: TodoExplanationPresentation) {
        todoExplanationTitleTextField.text = presentation.detailTitle
        todoExplanationDetailTextField.text = presentation.explanation
        todoExplanationDateTextField.text = DateFormatter().convertDateToString(date: presentation.date)
        todoExplanationCompletedSwitch.isOn = presentation.isCompleted
        notificationId = presentation.notificationId
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
        titleValidationLabel.textColor = .systemGreen
    }
    
    fileprivate func setInitialValues() {
        notificationDate = Calendar.current.dateComponents([.minute , .hour , .day , .month , .year], from: DateFormatter().convertStringToDate(date: todoExplanationDateTextField.text!))
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender.isOn == true{
            snackbarViewModel = SnackbarViewModel(type: .info, text: "You turned off notifications.", image: UIImage(systemName: "bell"))
            let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.2, height: 60)
            let snackbar = SnackbarView(viewModel: snackbarViewModel , frame: frame)
            showSnackbar(snackBar: snackbar)
        }else{
            snackbarViewModel = SnackbarViewModel(type: .info, text: "You turned on notifications.", image: UIImage(systemName: "bell"))
            let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.2, height: 60)
            let snackbar = SnackbarView(viewModel: snackbarViewModel , frame: frame)
            showSnackbar(snackBar: snackbar)
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        let date = DateFormatter().convertStringToDate(date: todoExplanationDateTextField.text)
        viewModel.addTodoDetail(title: todoExplanationTitleTextField.text!, explanation: todoExplanationDetailTextField.text!, date: date, iscCompleted: todoExplanationCompletedSwitch.isOn)
        if !todoExplanationCompletedSwitch.isOn{
            LocalNotificationManager.setNotification(notificationDate , notificationId , repeats: false, title: todoExplanationTitleTextField.text!, body: todoExplanationDetailTextField.text!, userInfo: ["aps" : ["todoIsReady":"true"]])
        }else{
            LocalNotificationManager.cancelThisNotification(notificationId)
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func titleTextFieldEdited(_ sender: UITextField) {
        guard let text = sender.text else { return }
        if text.isValid(titleValidityType){
            titleValidationLabel.text = "Everything seems ok."
            titleValidationLabel.textColor = .systemGreen
            todoExplanationSaveBtn.isEnabled = true
            
        }else{
            titleValidationLabel.text = "The title must contain at least 3 characters and at most 10 characters."
            titleValidationLabel.textColor = .systemPink
            todoExplanationSaveBtn.isEnabled = false
        }
    }
        
    @IBAction func detailTextFieldEdited(_ sender: UITextField) {
        guard let text = sender.text else { return }
        if text.isValid(detailValidityType){
            detailValidationLabel.text = "Everything seems ok."
            detailValidationLabel.textColor = .systemGreen
            todoExplanationSaveBtn.isEnabled = true
        }else{
            detailValidationLabel.text = "The detail must contain at least 8 characters and at most 25 characters."
            detailValidationLabel.textColor = .systemPink
            todoExplanationSaveBtn.isEnabled = false
        }
    }
    
    public func showSnackbar(snackBar : SnackbarView){
        let width = view.frame.size.width/1.2
        snackBar.frame = CGRect(x: (view.frame.size.width-width)/2, y: view.frame.size.height - 110, width: width, height: 60)
        view.addSubview(snackBar)
        
        UIView.animate(withDuration: 0.5, animations: {
            snackBar.frame = CGRect(x: (self.view.frame.size.width-width)/2, y: self.view.frame.size.height - 110, width: width, height: 60)
        },completion: { done in
            if done{
                DispatchQueue.main.asyncAfter(deadline: .now()+4, execute: {
                    UIView.animate(withDuration: 0.5) {
                        snackBar.frame = CGRect(x: (self.view.frame.size.width-width)/2, y: self.view.frame.size.height, width: width, height: 60)
                    } completion: { finished in
                        if finished{
                            snackBar.removeFromSuperview()
                        }
                    }
                })
            }
        })
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
            self.notificationDate = Calendar.current.dateComponents([.minute , .hour , .day , .month , .year], from: dateAndTimePicker.date)
        }
        self.todoExplanationDateTextField.resignFirstResponder()
    }
    
    @objc func datePickerHandler(datePicker : UIDatePicker){
        // You can use it to capture changes.
    }
}
