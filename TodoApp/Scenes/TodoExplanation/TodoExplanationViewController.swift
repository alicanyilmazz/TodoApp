//
//  TodoExplanationViewController.swift
//  TodoApp
//
//  Created by alican on 25.10.2021.
//

import UIKit

class TodoExplanationViewController: UIViewController {
    
    @IBOutlet var customView: UIView!
    
    @IBOutlet weak var todoExplanationTitleTextField: UITextField!

    @IBOutlet weak var PageTitleView: UIView!
    
    @IBOutlet weak var PageTitleViewLabel: UILabel!
    
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
        
    @IBOutlet weak var color1st: UIButton!
    
    @IBOutlet weak var color2nd: UIButton!
    
    @IBOutlet weak var color3rd: UIButton!
    
    @IBOutlet weak var color4th: UIButton!
    
    @IBOutlet weak var color5th: UIButton!
    
    @IBOutlet weak var color6th: UIButton!
    
    var selectedColorButton : Int = 0
    
    private var notificationDate : DateComponents!
    
    @IBOutlet weak var titleValidationLabel: UILabel!
    
    @IBOutlet weak var detailValidationLabel: UILabel!
    
    var isTitleValid : Bool! , isDetailValid : Bool! , isTheNotificationScheduled : Bool!
    
    var snackbarViewModel : SnackbarViewModel!
        
    var viewModel: TodoExplanationViewModelProtocol!
    
    let titleValidityType : String.ValidityType = .between3to25
    let detailValidityType : String.ValidityType = .between8to150
    
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
        
        //todoExplanationSaveBtn.setTitle(LocalizableStrings.addPageButtonTitle.description.localized(), for: .normal) --> Deprecated
        todoExplanationSaveBtn.setTitle(LocalizableStrings.addPageButtonTitle.description.localized(), for: .normal)
        todoExplanationSaveBtn.setTitleColor(ColorPalette.darkGray, for: .normal)
        todoExplanationSaveBtn.titleLabel?.font = UIFont(name: "Chalkboard SE Bold", size: 13)

        PageTitleView.clipsToBounds = false
        PageTitleView.layer.cornerRadius = 15
        PageTitleView.layer.shadowOpacity = 0.3
        PageTitleView.layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
        //PageTitleView.backgroundColor = ColorPalette.yellow
        
        color1st.layer.cornerRadius = 5
        color2nd.layer.cornerRadius = 5
        color3rd.layer.cornerRadius = 5
        color4th.layer.cornerRadius = 5
        color5th.layer.cornerRadius = 5
        color6th.layer.cornerRadius = 5
        setButtonUI()
        
        todoExplanationDateRightIcon.image = UIImage(systemName: "calendar")
        todoExplanationTextArea.returnKeyType = UIReturnKeyType.done
        
        PageTitleViewLabel.text = LocalizableStrings.todoChildTitle.description.localized()
        
        requestPermissionLabel.font = UIFont(name: "Chalkboard SE Bold", size: 10)
        
        switchIsEnabled()
        NotificationCenter.default.addObserver(self, selector: #selector(changeSwitchStatus(notification:)), name: .switchUINotification, object: nil)
    }
    
    
    @IBAction func colorTypeSelected(_ sender: UIButton) {
        setSelectedColor(sender.tag)
    }
       
    func setInitialSelectedColor(tagNumber : Int){
        setSelectedColor(tagNumber)
    }
    
    fileprivate func setSelectedColor(_ tagNumber: Int) {
        resetColorSelected()
        let borderWidth : CGFloat = 3
        switch tagNumber{
        case ColorButtonTag.First.rawValue : color1st.layer.borderWidth = borderWidth
             selectedColorButton = 0
        case ColorButtonTag.Second.rawValue : color2nd.layer.borderWidth = borderWidth
             selectedColorButton = 1
        case ColorButtonTag.Third.rawValue : color3rd.layer.borderWidth = borderWidth
             selectedColorButton = 2
        case ColorButtonTag.Fourth.rawValue : color4th.layer.borderWidth = borderWidth
             selectedColorButton = 3
        case ColorButtonTag.Fifth.rawValue : color5th.layer.borderWidth = borderWidth
             selectedColorButton = 4
        case ColorButtonTag.Sixth.rawValue : color6th.layer.borderWidth = borderWidth
             selectedColorButton = 5
        default : color1st.layer.borderWidth = borderWidth
             selectedColorButton = 0
        }
    }
    
    func resetColorSelected(){
        color1st.layer.borderWidth = 0
        color2nd.layer.borderWidth = 0
        color3rd.layer.borderWidth = 0
        color4th.layer.borderWidth = 0
        color5th.layer.borderWidth = 0
        color6th.layer.borderWidth = 0
    }
    
    func setButtonUI(){
        color1st.layer.borderColor = ColorPalette.lightGray.cgColor
        color2nd.layer.borderColor = ColorPalette.lightGray.cgColor
        color3rd.layer.borderColor = ColorPalette.lightGray.cgColor
        color4th.layer.borderColor = ColorPalette.lightGray.cgColor
        color5th.layer.borderColor = ColorPalette.lightGray.cgColor
        color6th.layer.borderColor = ColorPalette.lightGray.cgColor
        
        color1st.tintColor = ColorPalette.iconBlue
        color2nd.tintColor = ColorPalette.iconRed
        color3rd.tintColor = ColorPalette.iconGray
        color4th.tintColor = ColorPalette.iconGreen
        color5th.tintColor = ColorPalette.iconOrange
        color6th.tintColor = ColorPalette.iconPurple
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
        setInitialSelectedColor(tagNumber: presentation.colorType)
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
        PageTitleView.theme.backgroundColor = themed { $0.PageTitleViewBackgroundColor }
        //timeAnimationView.theme.backgroundColor = themed { $0.todoExplanationCustomViewThemeBackgroundColor }
        todoExplanationTextAreaLabel.textColor = .lightGray
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
            string: LocalizableStrings.textfieldTodoDetailTitle.description.localized(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        if todoExplanationTextArea.text.isEmpty {
            todoExplanationTextArea.text = LocalizableStrings.textfieldTodoDetail.description.localized()
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
            snackbarViewModel = SnackbarViewModel(type: .info, text: LocalizableStrings.snackbarOnMessage.description.localized(), image: UIImage(systemName: "bell"))
            let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.2, height: 60)
            let snackbar = SnackbarView(viewModel: snackbarViewModel , frame: frame)
            showSnackbar(snackBar: snackbar)
        }else{
            snackbarViewModel = SnackbarViewModel(type: .info, text: LocalizableStrings.snackbarOffMessage.description.localized(), image: UIImage(systemName: "bell"))
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
                    self.requestPermissionLabel.text = LocalizableStrings.notificationValidationMessage.description.localized()
                    self.requestPermissionLabel.textColor = .systemPink
                }
            }
        }   
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        if isTitleValid && isDetailValid{
            print("result of : \(notificationId)")
            let title = todoExplanationTitleTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let explanation = todoExplanationTextArea.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let isCompleted = todoExplanationCompletedSwitch.isOn
            let date = DateFormatter().convertStringToDate(date: todoExplanationDateTextField.text)
            
            if todoExplanationCompletedSwitch.isOn && isTheNotificationScheduled == false {
                viewModel.insertData(title: title , explanation: explanation, date: date, iscCompleted: isCompleted,isTheNotificationScheduled: true , colorType: selectedColorButton)
                LocalNotificationManager.setNotification(notificationDate , notificationId , repeats: false, title: title, body: explanation, userInfo: ["aps" : ["todoIsReady":"true"]])
            }
            else if todoExplanationCompletedSwitch.isOn && isTheNotificationScheduled == true{
                viewModel.insertData(title: title, explanation: explanation, date: date, iscCompleted: isCompleted,isTheNotificationScheduled: true , colorType: selectedColorButton)
                    LocalNotificationManager.cancelThisNotification(notificationId)
                    LocalNotificationManager.setNotification(notificationDate , notificationId , repeats: false, title: title, body: explanation, userInfo: ["aps" : ["todoIsReady":"true"]])
            }
            else if !todoExplanationCompletedSwitch.isOn && isTheNotificationScheduled == true{
                viewModel.insertData(title: title, explanation: explanation, date: date, iscCompleted: isCompleted,isTheNotificationScheduled: false , colorType: selectedColorButton)
                LocalNotificationManager.cancelThisNotification(notificationId)
            }else if !todoExplanationCompletedSwitch.isOn && isTheNotificationScheduled == false{
                viewModel.insertData(title: title, explanation: explanation, date: date, iscCompleted: isCompleted,isTheNotificationScheduled: false , colorType: selectedColorButton)
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
            titleValidationLabel.text = LocalizableStrings.validationOkMessage.description.localized()
            titleValidationLabel.textColor = .systemGreen
            isTitleValid = true
            //todoExplanationTitleTextField.setRightIcon(UIImage(systemName: "checkmark.circle")!)
            todoExplanationTitleRightIcon.image = UIImage(systemName: "checkmark.circle")
            todoExplanationTitleRightIcon.tintColor = .systemGreen
            
        }else{
            titleValidationLabel.text = LocalizableStrings.validationMessage3and25.description.localized()
            titleValidationLabel.textColor = .systemPink
            isTitleValid = false
            //todoExplanationTitleTextField.setRightIcon(UIImage(systemName: "xmark.circle")!)
            todoExplanationTitleRightIcon.image = UIImage(systemName: "xmark.circle")
            todoExplanationTitleRightIcon.tintColor = .systemPink
        }
    }
    
    public func showSnackbar(snackBar : SnackbarView){
        todoExplanationCompletedSwitch.isEnabled = false
        let width = view.frame.size.width/1.2
        snackBar.frame = CGRect(x: (view.frame.size.width-width)/2, y: view.frame.size.height - 110, width: width, height: 60)
        view.addSubview(snackBar)
        
        UIView.animate(withDuration: 0.5, animations: {
            snackBar.frame = CGRect(x: (self.view.frame.size.width-width)/2, y: self.view.frame.size.height - 110, width: width, height: 60)
        },completion: { done in
            if done{
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    UIView.animate(withDuration: 0.5) {
                        snackBar.frame = CGRect(x: (self.view.frame.size.width-width)/2, y: self.view.frame.size.height, width: width, height: 60)
                    } completion: { finished in
                        if finished{
                            snackBar.removeFromSuperview()
                            self.todoExplanationCompletedSwitch.isEnabled = true
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
                    self.requestPermissionLabel.text = LocalizableStrings.notificationValidationMessage.description.localized()
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.tag == textFieldType.titleTextField.rawValue){
            self.view.endEditing(true)
        }
        return false
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
            todoExplanationTextArea.text = LocalizableStrings.textfieldTodoDetail.description.localized()
            todoExplanationTextArea.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        detailValidator(text)
    }
    
    fileprivate func detailValidator(_ text: String) {
        todoExplanationTextAreaLabel.text = String(150 - text.count)
        
        if text.isValid(detailValidityType) && text != "Enter your todo detail" && text != "Liste detaylarını giriniz"{
            self.todoExplanationTextAreaIcon.image = UIImage(systemName: "checkmark.circle")
            self.todoExplanationTextAreaIcon.tintColor = .systemGreen
            detailValidationLabel.text = LocalizableStrings.validationOkMessage.description.localized()
            detailValidationLabel.textColor = .systemGreen
            isDetailValid = true
        }else{
            self.todoExplanationTextAreaIcon.image = UIImage(systemName: "x.circle")
            self.todoExplanationTextAreaIcon.tintColor = .systemPink
            detailValidationLabel.text = LocalizableStrings.validationMessage8and150.description.localized()
            detailValidationLabel.textColor = .systemPink
            isDetailValid = false
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
          textView.resignFirstResponder()
        }
        return self.textLimit(existingText: textView.text, newText: text, limit: 150)
    }
    
    private func textLimit(existingText: String?,
                           newText: String,
                           limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }
    
}
