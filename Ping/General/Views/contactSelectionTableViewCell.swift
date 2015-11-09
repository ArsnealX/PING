//
//  contectSelectionTableViewCell.swift
//  Ping
//
//  Created by Joshua Xiong on 7/29/15.
//  Copyright © 2015 Joshua Xiong. All rights reserved.
//

import UIKit

class contactSelectionTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    internal var isCellSelected:Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 5
        checkMarkImageView.hidden = true
        isCellSelected = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(model:TeamMemberModel) {
        avatarImageView.kf_setImageWithURL(NSURL(string: model.headImgUrl)!, placeholderImage: UIImage(named: "Image_Placeholder"))
        nameLabel.text = model.userName
    }
    
}
