//
//  TodoListAlertViewController.swift
//  TodoApp
//
//  Created by alican on 12.01.2022.
//

import UIKit

class TodoListAlertViewController: UIViewController , TodoListAlertViewProtocol {

    @IBOutlet var todoAlertBackgorundView: UIView!
    
    @IBOutlet weak var todoAlertView: UIView!
    
    @IBOutlet weak var todoAlertHeadView: UIView!
    
    @IBOutlet weak var todoAlertHeadTitle: UILabel!
    
    @IBOutlet weak var todoAlertMessage: UILabel!
    
    @IBOutlet weak var todoAlertTextfield: UITextField!
    
    @IBOutlet weak var todoAlertWarningLabel: UILabel!
    
    @IBOutlet weak var todoAlertInputView: UIView!
    
    @IBOutlet weak var todoAlertInputEachView: UIView!
    
    @IBOutlet weak var todoAlert1stButton: UIButton!
    
    @IBOutlet weak var todoAlert2ndButton: UIButton!
    
    @IBOutlet weak var todoAlert3rdButton: UIButton!
    
    @IBOutlet weak var todoAlert4thButton: UIButton!
    
    @IBOutlet weak var todoAlertAcceptButton: UIButton!
    
    @IBOutlet weak var todoAlertCancelButton: UIButton!

    @IBOutlet weak var todoAlertIconView: UIView!
    
    @IBOutlet weak var todoAlertIcon: UIImageView!
    
    var selectedColorButton : Int = 0
    
    var presenter : TodoListAlertPresenterProtocol!
    private var todo : TodoAlertPresentation!
    let titleValidityType : String.ValidityType = .between3to40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load()
        todoAlertTextfield.delegate = self
        setTheme()
        todoAlertMessage.text = LocalizableStrings.todoAlertPageMessageTitle.description.localized()
        todoAlertHeadTitle.text = LocalizableStrings.todoAlertPageTitleTitle.description.localized()
        
        todoAlertCancelButton.setTitle(LocalizableStrings.cancelButtonTitle.description.localized(), for: .normal)
        todoAlertCancelButton.setTitleColor(.white, for: .normal)
        todoAlertCancelButton.titleLabel?.font = UIFont(name: "Chalkboard SE Bold", size: 13)
        
        todoAlertAcceptButton.setTitle(LocalizableStrings.saveButtonTitle.description.localized(), for: .normal)
        todoAlertAcceptButton.setTitleColor(.white, for: .normal)
        todoAlertAcceptButton.titleLabel?.font = UIFont(name: "Chalkboard SE Bold", size: 13)

        setButtonUI()
        
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        //todoAlertCancelButton.titleLabel?.text = LocalizableStrings.cancelButtonTitle.description.localized()
        //todoAlertCancelButton.titleLabel?.font = UIFont.init(name: "Chalkboard SE Bold", size: 10)
        //todoAlertCancelButton.titleLabel?.textColor = UIColor.white
        
        //todoAlertAcceptButton.titleLabel?.text = LocalizableStrings.saveButtonTitle.description.localized()
        //todoAlertAcceptButton.setTitle( "asdasd", for: .normal)
        //todoAlertAcceptButton.setTitleColor(.white, for: .normal)
        //todoAlertAcceptButton.titleLabel?.font = UIFont(name: "Chalkboard SE Bold", size: 10)
        //todoAlertAcceptButton.titleLabel?.textColor = UIColor.white
        //todoAlertAcceptButton.titleLabel?.text = "asdasdasd"
        

    }
    
    func handleOutput(_ output: TodoListAlertPresenterOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showTodo(let todo):
            self.todo = todo
        }
    }
        
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func showTodo(_ presentation: TodoAlertPresentation) {
        todoAlertTextfield.text = presentation.title
        setInitialSelectedColor(tagNumber: presentation.colorType)
    }
    
    @IBAction func titleTextFieldEdited(_ sender: UITextField) {
        guard let text = sender.text else { return }
        titleValidator(text)
    }
    
    
    @IBAction func colorButtonClicked(_ sender: UIButton) {
        setSelectedColor(sender.tag)
    }
    
    
    @IBAction func acceptButtonClicked(_ sender: UIButton) {
        guard let text = todoAlertTextfield.text else { return }
        if text.isValid(titleValidityType){
            presenter.Insert(title: todoAlertTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines), colorType: selectedColorButton)
            _ = navigationController?.popViewController(animated: true)
        }else{
            todoAlertWarningLabel.text = LocalizableStrings.validationMessage3and40.description.localized()
            todoAlertWarningLabel.textColor = .systemPink
        }
    }
    
    fileprivate func titleValidator(_ text: String) {
        if text.isValid(titleValidityType){
            todoAlertWarningLabel.text = LocalizableStrings.validationOkMessage.description.localized()
            todoAlertWarningLabel.textColor = .systemGreen
        }else{
            todoAlertWarningLabel.text = LocalizableStrings.validationMessage3and40.description.localized()
            todoAlertWarningLabel.textColor = .systemPink
        }
    }
    
    fileprivate func setSelectedColor(_ tagNumber: Int) {
        resetColorSelected()
        let borderWidth : CGFloat = 3
        switch tagNumber{
        case ColorButtonTagMinimal.First.rawValue : todoAlert1stButton.layer.borderWidth = borderWidth
             selectedColorButton = 0
        case ColorButtonTagMinimal.Second.rawValue : todoAlert2ndButton.layer.borderWidth = borderWidth
             selectedColorButton = 1
        case ColorButtonTagMinimal.Third.rawValue : todoAlert3rdButton.layer.borderWidth = borderWidth
             selectedColorButton = 2
        case ColorButtonTagMinimal.Fourth.rawValue : todoAlert4thButton.layer.borderWidth = borderWidth
             selectedColorButton = 3
        default : todoAlert1stButton.layer.borderWidth = borderWidth
             selectedColorButton = 0
        }
    }
    
    func resetColorSelected(){
        todoAlert1stButton.layer.borderWidth = 0
        todoAlert2ndButton.layer.borderWidth = 0
        todoAlert3rdButton.layer.borderWidth = 0
        todoAlert4thButton.layer.borderWidth = 0
    }
    
    func setButtonUI(){
        todoAlert1stButton.layer.borderColor = ColorPalette.lightGray.cgColor
        todoAlert2ndButton.layer.borderColor = ColorPalette.lightGray.cgColor
        todoAlert3rdButton.layer.borderColor = ColorPalette.lightGray.cgColor
        todoAlert4thButton.layer.borderColor = ColorPalette.lightGray.cgColor
        
        todoAlert1stButton.backgroundColor = ColorPalette.iconBlue
        todoAlert2ndButton.backgroundColor = ColorPalette.iconRed
        todoAlert3rdButton.backgroundColor = ColorPalette.iconGray
        todoAlert4thButton.backgroundColor = ColorPalette.iconGreen
        
        todoAlert1stButton.layer.cornerRadius = 5
        todoAlert2ndButton.layer.cornerRadius = 5
        todoAlert3rdButton.layer.cornerRadius = 5
        todoAlert4thButton.layer.cornerRadius = 5
    }
    
    func setInitialSelectedColor(tagNumber : Int){
        setSelectedColor(tagNumber)
    }
    
    fileprivate func setTheme() {
        todoAlertBackgorundView.theme.backgroundColor = themed { $0.todoAlertBackgorundViewBackgroundColor }
        todoAlertView.theme.backgroundColor = themed { $0.todoAlertViewBackgroundColor }
         
        //todoAlertInputView.theme.backgroundColor = themed { $0.todoAlertViewBackgroundColor }
        
        todoAlertHeadView.theme.backgroundColor = themed { $0.todoAlertHeadViewBackgroundColor }
        todoAlertHeadView.theme.tintColor = themed { $0.todoAlertHeadViewTintColor }
        
        todoAlertHeadTitle.theme.backgroundColor = themed { $0.todoAlertHeadTitleBackgroundColor }
        todoAlertHeadTitle.theme.textColor = themed { $0.todoAlertHeadTitleTextColor }
        
        todoAlertMessage.theme.backgroundColor = themed { $0.todoAlertMessageBackgroundColor }
        todoAlertMessage.theme.textColor = themed { $0.todoAlertMessageTextColor }
        
        todoAlertIconView.theme.backgroundColor = themed { $0.todoAlertViewBackgroundColor }
        todoAlertIconView.layer.cornerRadius = 10
        todoAlertIcon.theme.backgroundColor = themed { $0.todoAlertViewBackgroundColor }
        todoAlertIcon.tintColor = ColorPalette.yellow
        
        todoAlertTextfield.theme.backgroundColor = themed { $0.todoAlertTextfieldBackgroundColor }
        todoAlertTextfield.tintColor = ColorPalette.yellow
        todoAlertTextfield.borderStyle = .none
        todoAlertTextfield.theme.textColor = themed { $0.todoAlertTextfieldTextColor }
        todoAlertTextfield.layer.borderWidth = 0
        todoAlertTextfield.layer.cornerRadius = 0
        todoAlertTextfield.attributedPlaceholder = NSAttributedString(
            string: LocalizableStrings.textfieldTodoTitle.description.localized(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        todoAlertWarningLabel.theme.backgroundColor = themed { $0.todoAlertWarningLabelBackgroundColor }
        todoAlertWarningLabel.theme.textColor = themed { $0.todoAlertWarningLabelTextColor }
        
        todoAlertAcceptButton.theme.backgroundColor = themed { $0.todoAlertAcceptButtonBackgroundColor }
        todoAlertAcceptButton.theme.tintColor = themed { $0.todoAlertAcceptButtonTintColor }
        todoAlertAcceptButton.theme.titleColor(from: themed { $0.todoAlertAcceptButtonTextColor }, for: .normal)
        
        todoAlertCancelButton.theme.backgroundColor = themed { $0.todoAlertCancelButtonBackgroundColor }
        todoAlertCancelButton.theme.tintColor = themed { $0.todoAlertCancelButtonTintColor}
        todoAlertCancelButton.theme.titleColor(from: themed { $0.todoAlertCancelButtonTextColor }, for: .normal)
        
        todoAlertView.layer.cornerRadius = 20
        todoAlertView.clipsToBounds = false
        todoAlertView.layer.shadowOpacity = 0.2
        todoAlertView.layer.shadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        todoAlertView.layer.shadowRadius = 5
        todoAlertView.layer.shadowOffset = CGSize(width: 2, height: 1)

        todoAlertTextfield.setLeftIcon(UIImage(systemName: "pencil.tip")!)
        
        todoAlertHeadView.layer.cornerRadius = 15
        todoAlertHeadView.clipsToBounds = false
        todoAlertHeadView.layer.shadowOpacity = 0.2
        todoAlertHeadView.layer.shadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        todoAlertHeadView.layer.shadowRadius = 5
        todoAlertHeadView.layer.shadowOffset = CGSize(width: 2, height: 1)
        
        todoAlertAcceptButton.layer.cornerRadius = 15
        todoAlertAcceptButton.clipsToBounds = true
        todoAlertAcceptButton.layer.shadowOpacity = 0.3
        todoAlertAcceptButton.layer.shadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        todoAlertAcceptButton.layer.shadowRadius = 15
        todoAlertAcceptButton.layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
        
        todoAlertCancelButton.layer.cornerRadius = 15
        todoAlertCancelButton.clipsToBounds = true
        todoAlertCancelButton.layer.shadowOpacity = 0.3
        todoAlertCancelButton.layer.shadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        todoAlertCancelButton.layer.shadowRadius = 15
        todoAlertCancelButton.layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
        
        todoAlertInputEachView.layer.cornerRadius = 15
        todoAlertInputEachView.theme.backgroundColor = themed { $0.todoAlertViewBackgroundColor }
        todoAlertInputEachView.clipsToBounds = false
        todoAlertInputEachView.layer.shadowOpacity = 0.3
        todoAlertInputEachView.layer.shadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        todoAlertInputEachView.layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
    }
}
 
extension TodoListAlertViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
