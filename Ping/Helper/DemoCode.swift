//
//  DemoCode.swift
//  Ping
//
//  Created by BeautySiteMac on 3/11/2015.
//  Copyright © 2015 Kejukeji. All rights reserved.
//

import UIKit

class DemoCode: NSObject {
    class func MainViewControllerDemoCode(cell:tasksTableViewCell?, indexPath:NSIndexPath) {
        if indexPath.row == 0 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_1")
            cell?.nameLabel.text = "熊一"
            cell?.contentLabel.text = "今天：1.数据填充 2.字段修改"
            cell?.dateLabel.text = "07.23"
            cell?.statusLabel.text = "审核中"
            cell?.statusLabel.textColor = APP_THEME_COLOR
        }else if indexPath.row == 1 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_2")
            cell?.nameLabel.text = "赵二"
            cell?.contentLabel.text = "今天：1.数据填充 2.字段修改"
            cell?.dateLabel.text = "07.23"
            cell?.statusLabel.text = "已通过"
            cell?.statusLabel.textColor = APP_PASS_COLOR
            cell?.isReadImageView.hidden = true
        }else if indexPath.row == 2 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_3")
            cell?.nameLabel.text = "钱三"
            cell?.contentLabel.text = "今天：1.数据填充 2.字段修改"
            cell?.dateLabel.text = "07.23"
            cell?.statusLabel.text = "已通过"
            cell?.statusLabel.textColor = APP_PASS_COLOR
            cell?.isReadImageView.hidden = true
        }else if indexPath.row == 3 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_4")
            cell?.nameLabel.text = "孙四"
            cell?.contentLabel.text = "今天：1.数据填充 2.字段修改"
            cell?.dateLabel.text = "07.23"
            cell?.statusLabel.text = "审核中"
            cell?.statusLabel.textColor = APP_THEME_COLOR
        }else if indexPath.row == 4 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_5")
            cell?.nameLabel.text = "李五"
            cell?.contentLabel.text = "今天：1.数据填充 2.字段修改"
            cell?.dateLabel.text = "07.23"
            cell?.statusLabel.text = "未通过"
            cell?.statusLabel.textColor = APP_ALERT_COLOR
            cell?.isReadImageView.hidden = true
        }else if indexPath.row == 5 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_6")
            cell?.nameLabel.text = "周六"
            cell?.contentLabel.text = "今天：1.数据填充 2.字段修改"
            cell?.dateLabel.text = "07.23"
            cell?.statusLabel.text = "审核中"
            cell?.statusLabel.textColor = APP_THEME_COLOR
            cell?.isReadImageView.hidden = true
        }else if indexPath.row == 6 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_7")
            cell?.nameLabel.text = "吴七"
            cell?.contentLabel.text = "今天：1.数据填充 2.字段修改"
            cell?.dateLabel.text = "07.23"
            cell?.statusLabel.text = "审核中"
            cell?.statusLabel.textColor = APP_THEME_COLOR
            cell?.isReadImageView.hidden = true
        }else if indexPath.row == 7 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_8")
            cell?.nameLabel.text = "郑八"
            cell?.contentLabel.text = "今天：1.数据填充 2.字段修改"
            cell?.dateLabel.text = "07.23"
            cell?.statusLabel.text = "审核中"
            cell?.statusLabel.textColor = APP_THEME_COLOR
        }else if indexPath.row == 8 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_9")
            cell?.nameLabel.text = "王九"
            cell?.contentLabel.text = "今天：1.数据填充 2.字段修改"
            cell?.dateLabel.text = "07.23"
            cell?.statusLabel.text = "审核中"
            cell?.statusLabel.textColor = APP_THEME_COLOR
            cell?.isReadImageView.hidden = true
        }else {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_10")
            cell?.nameLabel.text = "冯十"
            cell?.contentLabel.text = "1、小区项目，整体进度正常，下周4交付，周5验收，预计绝大部分功能和流程都ok。 "
            cell?.dateLabel.text = "07.24"
            cell?.statusLabel.text = "已通过"
            cell?.statusLabel.textColor = APP_PASS_COLOR
            cell?.isReadImageView.hidden = true
        }
    }
    
    class func TeamViewControllerDemoCode(cell:teamRankingTableViewCell?, indexPath:NSIndexPath) {
        if indexPath.row == 0 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_1")
            cell?.nameLabel.text = "熊一"
            cell?.scoreLabel.text = "715"
            cell?.addScoreLabel.text = "+" + "23"
        }else if indexPath.row == 1 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_2")
            cell?.nameLabel.text = "赵二"
            cell?.scoreLabel.text = "454"
            cell?.addScoreLabel.text = "+" + "33"
        }else if indexPath.row == 2 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_3")
            cell?.nameLabel.text = "钱三"
            cell?.scoreLabel.text = "388"
            cell?.addScoreLabel.text = "+" + "15"
        }else if indexPath.row == 3 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_4")
            cell?.nameLabel.text = "孙四"
            cell?.scoreLabel.text = "357"
            cell?.addScoreLabel.text = "-" + "29"
        }else if indexPath.row == 4 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_5")
            cell?.nameLabel.text = "李五"
            cell?.scoreLabel.text = "331"
            cell?.addScoreLabel.text = "+" + "12"
        }else if indexPath.row == 5 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_6")
            cell?.nameLabel.text = "周六"
            cell?.scoreLabel.text = "324"
            cell?.addScoreLabel.text = "-" + "48"
        }else if indexPath.row == 6 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_7")
            cell?.nameLabel.text = "吴七"
            cell?.scoreLabel.text = "121"
            cell?.addScoreLabel.text = "+" + "53"
        }else if indexPath.row == 7 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_8")
            cell?.nameLabel.text = "郑八"
            cell?.scoreLabel.text = "121"
            cell?.addScoreLabel.text = "+" + "53"
        }else if indexPath.row == 8 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_9")
            cell?.nameLabel.text = "王九"
            cell?.scoreLabel.text = "121"
            cell?.addScoreLabel.text = "+" + "53"
        }else {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_10")
            cell?.nameLabel.text = "冯十"
            cell?.scoreLabel.text = "121"
            cell?.addScoreLabel.text = "+" + "53"
        }
    }
}
