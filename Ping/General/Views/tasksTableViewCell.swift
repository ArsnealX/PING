//
//  tasksTableViewCell.swift
//  Ping
//
//  Created by Joshua Xiong on 7/26/15.
//  Copyright © 2015 Joshua Xiong. All rights reserved.
//

import UIKit
import Kingfisher

class tasksTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var isReadImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 10
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(model:TaskDetailModel) {
        nameLabel.text = model.userName
        contentLabel.text = model.taskContent
        dateLabel.text = JXTools.timestampToReadableDate(model.createTimeStamp)
        avatarImageView.kf_setImageWithURL(NSURL(string: model.headsImgURL)!, placeholderImage: UIImage(named: "Image_Placeholder"))
        if model.isRead {
            isReadImageView.hidden = true
        }else {
            isReadImageView.hidden = false
        }
        
        if model.taskState == "2" {
            statusLabel.textColor = APP_THEME_COLOR
            statusLabel.text = "审核中"
        }else if model.taskState == "6" {
            statusLabel.textColor = APP_PASS_COLOR
            statusLabel.text = "已通过"
        }else {
            statusLabel.textColor = APP_ALERT_COLOR
            statusLabel.text = "未通过"
        }
    }
    
}
