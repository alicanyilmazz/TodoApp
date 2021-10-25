//
//  TodoDetailCell.swift
//  TodoApp
//
//  Created by alican on 25.10.2021.
//

import UIKit

class TodoDetailCell: UITableViewCell {


    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var avatarLbl: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
