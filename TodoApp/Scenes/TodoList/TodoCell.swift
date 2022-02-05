//
//  TodoCell.swift
//  TodoApp
//
//  Created by alican on 2.11.2021.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var customCell: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var todoTitleLbl: UILabel!
    @IBOutlet weak var customView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTheme()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func setTheme() {
        customCell.theme.backgroundColor = themed { $0.todoListCustomCellBackgorundColor } // customViewBackgroundColor
        customCell.theme.tintColor = themed { $0.customCellTintColor }
        customView.theme.backgroundColor = themed { $0.todoListCustomViewBackgorundColor } // todoTitleLblBackgroundColor
        customView.theme.tintColor = themed { $0.customViewTintColor }
        avatarImage.theme.backgroundColor = themed { $0.customViewBackgroundColor }
        
        todoTitleLbl.theme.backgroundColor = themed { $0.todoTitleLblBackgroundColor }
        todoTitleLbl.theme.textColor = themed { $0.todoTitleLblTextColor }
        
        customCell.clipsToBounds = true
        /*
        customCell.layer.cornerRadius = 20
        customView.clipsToBounds = false
        customView.layer.shadowOpacity = 0.2
        customView.layer.shadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        customView.layer.shadowRadius = 5
        customView.layer.shadowOffset = CGSize(width: 2, height: 1)
        */
        //customView.layer.shouldRasterize = true
        
        customView.layer.cornerRadius = 15
        customView.clipsToBounds = false
        customView.layer.shadowOpacity = 0.2
        customView.layer.shadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        customView.layer.shadowRadius = 5
        customView.layer.shadowOffset = CGSize(width: 2, height: 1)
    }
}
