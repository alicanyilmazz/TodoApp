//
//  DateTimePickerExtensions.swift
//  TodoApp
//
//  Created by alican on 4.11.2021.
//

import Foundation
import UIKit

extension UIDatePicker{
    func createDatePicker(_vc : UIViewController , textField : inout UITextField){
        let vc = _vc as! TodoExplanationViewController
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(vc, action: #selector(vc.datePickerHandler(datePicker:)), for: .valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.2470588235, blue: 0.2941176471, alpha: 0.8501358537)
        datePicker.tintColor = #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1)
        datePicker.setValue(#colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1) , forKeyPath: "textColor")
        datePicker.minimumDate = Calendar.current.date(byAdding: .minute, value: 0, to: Date())
        textField.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: vc.view.frame.width, height: 50))
        toolbar.tintColor = #colorLiteral(red: 0.1960784314, green: 0.2470588235, blue: 0.2941176471, alpha: 0.8501358537)
        toolbar.barTintColor = #colorLiteral(red: 0.9882352941, green: 0.7490196078, blue: 0.2862745098, alpha: 1)
        toolbar.backgroundColor = .orange
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: vc, action: #selector(vc.cancelButtonClick))
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: vc, action: #selector(vc.doneButtonClick))
        let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelButton,flexibleButton,doneButton], animated: true)
        textField.inputAccessoryView = toolbar
    }
}

extension DateFormatter{
    func convertStringToDate(date stringDate : String?) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        guard let date = stringDate, !date.isEmpty else {
            return dateFormatter.date(from: "Dec 22, 9:56 AM")!
        }
        return dateFormatter.date(from: date)!
    }
    
    func convertDateToString(date datetime : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter.string(from: datetime)
    }
}

