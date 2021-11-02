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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
