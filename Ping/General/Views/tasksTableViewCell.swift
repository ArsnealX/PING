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
//    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var imageBgView: UIView!
    
    @IBOutlet weak var bottomRightImgView: UIImageView!
    @IBOutlet weak var bottomLeftImgView: UIImageView!
    @IBOutlet weak var topRightImgView: UIImageView!
    @IBOutlet weak var topLeftImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var readView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
          imageBgView.layer.borderColor = UIColor.colorWithRGB(210, green: 210, blue: 210).CGColor
        imageBgView.layer.borderWidth = 0.5
        readView.layer.masksToBounds = true
        readView.layer.cornerRadius = 6
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(model:TaskDetailModel) {
        nameLabel.text = model.userName
        contentLabel.text = model.taskContent
        dateLabel.text = JXTools.timestampToReadableDate(model.createTimeStamp)
        topLeftImgView.kf_setImageWithURL(NSURL(string: model.headsImgURL)!, placeholderImage: UIImage(named: "Image_Placeholder"))
        if model.isRead {
            readView.hidden = true
        }else {
            readView.hidden = false
        }
        
        if model.taskState == "1" {
            statusLabel.textColor = APP_THEME_COLOR
            statusLabel.text = "审核中"
        }else if model.taskState == "2" {
            statusLabel.textColor = APP_PASS_COLOR
            statusLabel.text = "已通过"
        }else {
            statusLabel.textColor = APP_ALERT_COLOR
            statusLabel.text = "未通过"
        }
    }
    
}
