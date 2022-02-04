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
    
    @IBOutlet weak var timeAnimationView: AnimationView!
    
    @IBOutlet weak var todoExplanationTitleTextField: UITextField!
    
    @IBOutlet weak var todoExplanationTitleView: UIView!
    
    @IBOutlet weak var todoExplanationTitleLeftIcon: UIImageView!
    
    @IBOutlet weak var todoExplanationTitleRightIcon: UIImageView!
    
    @IBOutlet weak var textAreaView: UIView!
    
    @IBOutlet weak var todoExplanationTextArea: UITextView!
    
    @IBOutlet weak var todoExplanationTextAreaIcon: UIImageView!
    
    @IBOutlet weak var todoExplanationTextAreaLabel: UILabel!
    
    @IBOutlet weak var todoExplanationDateTextField: UITextField!
    
    @IBOutlet weak var todoExplanationDateRightIcon: UIImageView!
    
    @IBOutlet weak var todoExplanationDateView: UIView!
    
    @IBOutlet weak var todoExplanationCompletedSwitch: UISwitch!
    
    @IBOutlet weak var requestPermissionLabel: UILabel!
    
    @IBOutlet weak var todoExplanationSaveBtn: UIButton!
    
    private var notificationDate : DateComponents!
    
    @IBOutlet weak var titleValidationLabel: UILabel!
    
    @IBOutlet weak var detailValidationLabel: UILabel!
    
    var isTitleValid : Bool! , isDetailValid : Bool! , isTheNotificationScheduled : Bool!
    
    var snackbarViewModel : SnackbarViewModel!
        
    var viewModel: TodoExplanationViewModelProtocol!
    
    let titleValidityType : String.ValidityType = .between3to25
    let detailValidityType : String.ValidityType = .between8to42
    
    var notificationId : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        todoExplanationTitleTextField.delegate = self
        todoExplanationTitleTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        todoExplanationDateTextField.delegate = self
        viewModel.delegate = self
        todoExplanationTextArea.delegate = self
        
        todoExplanationTitleTextField.tag = 1
        todoExplanationDateTextField.tag = 2
        
        viewModel.load()
        setAnimation()
        setTheme()
        setUIComponent()
        setInitialValues()
        setTextFieldIcons()
        setTextFieldPlaceHolder()
        setInitialValidation()
        
        todoExplanationTitleTextField.borderStyle = .none
        todoExplanationDateTextField.borderStyle = .none
        
        textAreaView.layer.cornerRadius = 15
        textAreaView.clipsToBounds = false
        textAreaView.layer.shadowOpacity = 0.3
        textAreaView.layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
        
        todoExplanationTitleView.layer.cornerRadius = 15
        todoExplanationTitleView.clipsToBounds = false
        todoExplanationTitleView.layer.shadowOpacity = 0.3
        todoExplanationTitleView.layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
        
        todoExplanationDateView.layer.cornerRadius = 15
        todoExplanationDateView.clipsToBounds = false
        todoExplanationDateView.layer.shadowOpacity = 0.3
        todoExplanationDateView.layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
        
        todoExplanationDateRightIcon.image = UIImage(systemName: "calendar")
        
        todoExplanationTextArea.returnKeyType = UIReturnKeyType.done
        
        switchIsEnabled()
        NotificationCenter.default.addObserver(self, selector: #selector(changeSwitchStatus(notification:)), name: .switchUINotification, object: nil)
    }
    
}

extension TodoExplanationViewController: TodoExplanationViewModelDelegate {
    
    func showDetail(_ presentation: TodoExplanationPresentation) {
        todoExplanationTitleTextField.text = presentation.detailTitle
        todoExplanationTextArea.text = presentation.explanation
        todoExplanationDateTextField.text = DateFormatter().convertDateToString(date: presentation.date)
        todoExplanationCompletedSwitch.isOn = presentation.isCompleted
        notificationId = presentation.notificationId
        isTheNotificationScheduled = presentation.isTheNotificationScheduled
    }
}

extension TodoExplanationViewController{
    
    fileprivate func setTheme() {
        todoExplanationTitleTextField.theme.backgroundColor = themed { $0.todoExplanationTitleTextFieldBackgroundColor }
        todoExplanationTitleTextField.theme.textColor = themed { $0.todoExplanationTitleTextFieldTextColor }
        todoExplanationTitleView.theme.backgroundColor = themed { $0.todoExplanationTitleTextFieldBackgroundColor }
        todoExplanationTextArea.theme.backgroundColor = themed { $0.todoExplanationDetailTextFieldBackgroundColor }
        todoExplanationTextArea.theme.textColor = themed { $0.todoExplanationDetailTextFieldTextColor }
        textAreaView.theme.backgroundColor = themed { $0.todoExplanationDetailTextFieldBackgroundColor }
        todoExplanationDateTextField.theme.backgroundColor = themed { $0.todoExplanationDateTextFieldBackgroundColor }
        todoExplanationDateTextField.theme.textColor = themed { $0.todoExplanationDateTextFieldTextColor }
        todoExplanationDateView.theme.backgroundColor = themed { $0.todoExplanationDateTextFieldBackgroundColor }
        todoExplanationCompletedSwitch.theme.backgroundColor = themed { $0.todoExplanationCompletedSwitchLblBackgroundColor }
        todoExplanationCompletedSwitch.theme.onTintColor = themed { $0.todoExplanationCompletedSwitchOnTintColor }
        todoExplanationCompletedSwitch.theme.thumbTintColor = themed { $0.todoExplanationCompletedSwitchThumbTintColor }
        todoExplanationSaveBtn.theme.backgroundColor = themed { $0.todoExplanationSaveBtnBackgroundColor }
        todoExplanationSaveBtn.theme.tintColor = themed { $0.todoExplanationSaveBtnTextColor }
        customView.theme.backgroundColor = themed { $0.todoExplanationCustomViewThemeBackgroundColor }
        timeAnimationView.theme.backgroundColor = themed { $0.todoExplanationCustomViewThemeBackgroundColor }
        todoExplanationTextAreaLabel.textColor = .lightGray
    }
    
    fileprivate func setAnimation() {
        animationView.backgroundColor = .clear
        animationView.loopMode = .loop
        animationView.play()
        
        timeAnimationView.backgroundColor = .clear
        timeAnimationView.loopMode = .loop
        timeAnimationView.play()
    }
    
    fileprivate func setUIComponent() {
        todoExplanationSaveBtn.layer.cornerRadius = 15
        todoExplanationSaveBtn.layer.shadowOpacity = 0.3
        todoExplanationSaveBtn.layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
        //todoExplanationSaveBtn.layer.borderWidth = 1
        //todoExplanationSaveBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        titleValidationLabel.textColor = .systemGreen
    }
    
    fileprivate func setTextFieldIcons() {
        //todoExplanationTitleTextField.setLeftIcon(UIImage(systemName: "pencil")!)
        //todoExplanationDateTextField.setLeftIcon(UIImage(systemName: "calendar")!)
        todoExplanationTitleLeftIcon.image = UIImage(systemName: "pencil")?.withTintColor(.systemPink)
    }
    
    fileprivate func setTextFieldPlaceHolder() {
        todoExplanationTitleTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter your todo title",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        if todoExplanationTextArea.text.isEmpty {
            todoExplanationTextArea.text = "Enter your todo detail"
            todoExplanationTextArea.textColor = UIColor.lightGray
        }
    }
    
    fileprivate func setInitialValues() {
        notificationDate = Calendar.current.dateComponents([.minute , .hour , .day , .month , .year], from: DateFormatter().convertStringToDate(date: todoExplanationDateTextField.text!))
    }
    
    fileprivate func setInitialValidation() {
        if todoExplanationTitleTextField.text!.isValid(titleValidityType) && todoExplanationTextArea.text!.isValid(detailValidityType){
            isTitleValid = true
            isDetailValid = true
        }else{
            isTitleValid = false
            isDetailValid = false
        }
    }
    /*
    fileprivate func setButtonValidation() {
        todoExplanationTitleTextField.addTarget(self, action: #selector(buttonValidation), for: .editingChanged)
        //todoExplanationTextArea.addTarget(self, action: #selector(buttonValidation), for: .editingChanged)
    }
    
    @objc func buttonValidation(){
        if(isTitleValid == true && isDetailValid == true){
            todoExplanationSaveBtn.isEnabled = true
        }else{
            todoExplanationSaveBtn.isEnabled = false
        }
    }
    */
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender.isOn == true{
            snackbarViewModel = SnackbarViewModel(type: .info, text: "You turned on notifications.", image: UIImage(systemName: "bell"))
            let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.2, height: 60)
            let snackbar = SnackbarView(viewModel: snackbarViewModel , frame: frame)
            showSnackbar(snackBar: snackbar)
        }else{
            snackbarViewModel = SnackbarViewModel(type: .info, text: "You turned off notifications.", image: UIImage(systemName: "bell"))
            let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.2, height: 60)
            let snackbar = SnackbarView(viewModel: snackbarViewModel , frame: frame)
            showSnackbar(snackBar: snackbar)
        }
    }
    
    func switchIsEnabled(){
        LocalNotificationManager.getNotificationPermissionStatus{ (isEnable) in
            if isEnable == true{
                DispatchQueue.main.async {
                    self.todoExplanationCompletedSwitch.isEnabled = true
                    self.requestPermissionLabel.text = ""
                }
            }else{
                DispatchQueue.main.async {
                    self.todoExplanationCompletedSwitch.isEnabled = false
                    self.requestPermissionLabel.text = "Please give permission to create notification."
                    self.requestPermissionLabel.textColor = .systemPink
                }
            }
        }   
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        if isTitleValid && isDetailValid{
            let date = DateFormatter().convertStringToDate(date: todoExplanationDateTextField.text)
            if todoExplanationCompletedSwitch.isOn && isTheNotificationScheduled == false {
                viewModel.addTodoDetail(title: todoExplanationTitleTextField.text!, explanation: todoExplanationTextArea.text!, date: date, iscCompleted: todoExplanationCompletedSwitch.isOn,isTheNotificationScheduled: true)
                LocalNotificationManager.setNotification(notificationDate , notificationId , repeats: false, title: todoExplanationTitleTextField.text!, body: todoExplanationTextArea.text!, userInfo: ["aps" : ["todoIsReady":"true"]])
            }
            else if todoExplanationCompletedSwitch.isOn && isTheNotificationScheduled == true{
                viewModel.addTodoDetail(title: todoExplanationTitleTextField.text!, explanation: todoExplanationTextArea.text!, date: date, iscCompleted: todoExplanationCompletedSwitch.isOn,isTheNotificationScheduled: true)
                    LocalNotificationManager.cancelThisNotification(notificationId)
                    LocalNotificationManager.setNotification(notificationDate , notificationId , repeats: false, title: todoExplanationTitleTextField.text!, body: todoExplanationTextArea.text!, userInfo: ["aps" : ["todoIsReady":"true"]])
            }
            else if !todoExplanationCompletedSwitch.isOn && isTheNotificationScheduled == true{
                viewModel.addTodoDetail(title: todoExplanationTitleTextField.text!, explanation: todoExplanationTextArea.text!, date: date, iscCompleted: todoExplanationCompletedSwitch.isOn,isTheNotificationScheduled: false)
                LocalNotificationManager.cancelThisNotification(notificationId)
            }else if !todoExplanationCompletedSwitch.isOn && isTheNotificationScheduled == false{
                viewModel.addTodoDetail(title: todoExplanationTitleTextField.text!, explanation: todoExplanationTextArea.text!, date: date, iscCompleted: todoExplanationCompletedSwitch.isOn,isTheNotificationScheduled: false)
            }

            _ = navigationController?.popViewController(animated: true)
        }
        else{
        guard let titleText = todoExplanationTitleTextField.text else { return }
        titleValidator(titleText)
        guard let detailText = todoExplanationTextArea.text else { return }
        detailValidator(detailText)
      }
    }
        
    @IBAction func titleTextFieldEdited(_ sender: UITextField) {
        guard let text = sender.text else { return }
        titleValidator(text)
    }
    
    fileprivate func titleValidator(_ text: String) {
        if text.isValid(titleValidityType){
            titleValidationLabel.text = "Everything seems ok."
            titleValidationLabel.textColor = .systemGreen
            isTitleValid = true
            //todoExplanationTitleTextField.setRightIcon(UIImage(systemName: "checkmark.circle")!)
            todoExplanationTitleRightIcon.image = UIImage(systemName: "checkmark.circle")
            todoExplanationTitleRightIcon.tintColor = .systemGreen
            
        }else{
            titleValidationLabel.text = "The title must contain at least 3 characters and at most 10 characters."
            titleValidationLabel.textColor = .systemPink
            isTitleValid = false
            //todoExplanationTitleTextField.setRightIcon(UIImage(systemName: "xmark.circle")!)
            todoExplanationTitleRightIcon.image = UIImage(systemName: "xmark.circle")
            todoExplanationTitleRightIcon.tintColor = .systemPink
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
    
    @objc func changeSwitchStatus(notification : Notification){
        LocalNotificationManager.getNotificationPermissionStatus{ (isEnable) in
            if isEnable == true{
                DispatchQueue.main.async {
                    self.todoExplanationCompletedSwitch.isEnabled = true
                    self.requestPermissionLabel.text = ""
                }
            }else{
                DispatchQueue.main.async {
                    self.todoExplanationCompletedSwitch.isOn = false
                    self.todoExplanationCompletedSwitch.isEnabled = false
                    self.requestPermissionLabel.text = "Please give permission to create notification."
                    self.requestPermissionLabel.textColor = .systemPink
                }
            }
        }
    }
}

extension TodoExplanationViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.tag == textFieldType.dateTextField.rawValue){
            UIDatePicker().createDatePicker(_vc: self, textField: &todoExplanationDateTextField)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 25
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

extension TodoExplanationViewController : UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if todoExplanationTextArea.textColor == UIColor.lightGray{
            todoExplanationTextArea.text = nil
            todoExplanationTextArea.theme.textColor = themed { $0.todoExplanationDetailTextFieldTextColor }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if todoExplanationTextArea.text.isEmpty{
            todoExplanationTextArea.text = "Enter your todo detail"
            todoExplanationTextArea.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        detailValidator(text)
    }
    
    fileprivate func detailValidator(_ text: String) {
        todoExplanationTextAreaLabel.text = String(180 - text.count)
        
        if text.isValid(detailValidityType) && text != "Enter your todo detail"{
            self.todoExplanationTextAreaIcon.image = UIImage(systemName: "checkmark.circle")
            self.todoExplanationTextAreaIcon.tintColor = .systemGreen
            detailValidationLabel.text = "Everything seems ok."
            detailValidationLabel.textColor = .systemGreen
            isDetailValid = true
        }else{
            self.todoExplanationTextAreaIcon.image = UIImage(systemName: "x.circle")
            self.todoExplanationTextAreaIcon.tintColor = .systemPink
            detailValidationLabel.text = "The detail must contain at least 8 characters and at most 180 characters."
            detailValidationLabel.textColor = .systemPink
            isDetailValid = false
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
          textView.resignFirstResponder()
        }
        return self.textLimit(existingText: textView.text, newText: text, limit: 180)
    }
    
    private func textLimit(existingText: String?,
                           newText: String,
                           limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }
    
}
