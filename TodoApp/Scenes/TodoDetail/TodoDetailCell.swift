//
//  TodoDetailCell.swift
//  TodoApp
//
//  Created by alican on 25.10.2021.
//

import UIKit

class TodoDetailCell: UITableViewCell {

    @IBOutlet weak var customCell: UIView!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var avatarLbl: UIImageView!
    @IBOutlet weak var isCompletedLbl: UIImageView!
    @IBOutlet weak var detailTitleLbl: UILabel!
    @IBOutlet weak var calendarAvatar: UIImageView!
        
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
        detailLbl.theme.textColor = themed { $0.detailLblTextColor }
        detailLbl.theme.backgroundColor = themed { $0.detailLblBackgroundColor }
        detailLbl.theme.tintColor = themed { $0.detailLblTintColor }
        detailTitleLbl.theme.textColor = themed { $0.detailTitleLblTextColor }
        detailTitleLbl.theme.backgroundColor = themed { $0.detailTitleLblBackgroundColor }
        detailTitleLbl.theme.tintColor = themed { $0.detailTitleLblTintColor }
        isCompletedLbl.theme.backgroundColor = themed { $0.isCompletedLblBackgroundColor }
        isCompletedLbl.theme.tintColor = themed { $0.isCompletedLblTintColor }
        calendarAvatar.theme.backgroundColor = themed { $0.calendarAvatarBackgroundColor }
        calendarAvatar.theme.tintColor = themed { $0.calendarAvatarTintColor }
        dateLbl.theme.textColor = themed { $0.dateLblTextColor }
        dateLbl.theme.backgroundColor = themed { $0.dateLblBackgroundColor }
        dateLbl.theme.tintColor = themed { $0.dateLblTintColor }
        avatarLbl.theme.backgroundColor = themed { $0.customViewBackgroundColor }
        
        customView.layer.cornerRadius = 20
        customView.clipsToBounds = false
        customView.layer.shadowOpacity = 0.2
        customView.layer.shadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        customView.layer.shadowRadius = 5
        customView.layer.shadowOffset = CGSize(width: 2, height: 1)
    }

}
