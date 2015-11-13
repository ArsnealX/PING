//
//  teamRankingTableViewCell.swift
//  
//
//  Created by Joshua Xiong on 8/7/15.
//
//

import UIKit

class teamRankingTableViewCell: UITableViewCell {
    @IBOutlet weak var rankingLabelContainerView: UIView!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rankingLabelContainerView.layer.masksToBounds = true
        rankingLabelContainerView.layer.cornerRadius = 18
        rankingLabelContainerView.layer.borderWidth = 1
        rankingLabelContainerView.layer.borderColor = UIColor(red:0, green:0.69, blue:0.45, alpha:1).CGColor
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 10
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(model:TeamRankingModel) {
        avatarImageView.kf_setImageWithURL(NSURL(string: model.headImgUrl)!, placeholderImage: UIImage(named: "Image_Placeholder"))
        nameLabel.text = model.userName
        if model.monthPoint == "0" {
            addScoreLabel.text = ""
        }else {
            addScoreLabel.text = "+"+model.monthPoint
        }
        scoreLabel.text = model.yearPoint
    }
    
}
