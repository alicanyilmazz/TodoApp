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
        customCell.theme.backgroundColor = themed { $0.customCellBackgroundColor }
        customCell.theme.tintColor = themed { $0.customCellTintColor }
        customView.theme.backgroundColor = themed { $0.customViewBackgroundColor }
        customView.theme.tintColor = themed { $0.customViewTintColor }
        avatarImage.theme.backgroundColor = themed { $0.customViewBackgroundColor }
        avatarImage.tintColor = #colorLiteral(red: 0.9891422391, green: 0.7494880557, blue: 0.2886847556, alpha: 1)
        todoTitleLbl.theme.backgroundColor = themed { $0.todoTitleLblBackgroundColor }
        todoTitleLbl.theme.textColor = themed { $0.todoTitleLblTextColor }
    }
    
}
