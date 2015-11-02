//
//  TeamViewController.swift
//  
//
//  Created by Joshua Xiong on 8/7/15.
//
//

import UIKit

class TeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var teamRankingTableView: UITableView!
    @IBOutlet weak var verticalGreenLine: UIImageView!
    @IBOutlet weak var introductionView: UIView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        let nibNameOrNil:String? = "TeamViewController"
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        teamRankingTableView?.registerNib(UINib(nibName: "teamRankingTableViewCell", bundle: nil), forCellReuseIdentifier: "teamRankingTableViewCell")
        teamRankingTableView?.dataSource = self
        teamRankingTableView?.delegate = self
//        teamRankingTableView?.separatorStyle = .None
        teamRankingTableView.separatorInset = UIEdgeInsets(top: 0,left: 65,bottom: 0,right: 0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.configUI()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "teamRankingTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? teamRankingTableViewCell
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
            let delta = CGFloat(indexPath.row / 10)
            let rankingColor = UIColor(red:0 + delta * 2, green:0.75 + delta, blue:0.45 + delta * 2, alpha:1)
            cell?.rankingLabelContainerView.backgroundColor = rankingColor
            cell?.rankingLabel.backgroundColor = rankingColor
            cell?.rankingLabel.textColor = UIColor.whiteColor()
            cell?.scoreLabel.textColor = APP_THEME_COLOR
        }else {
            let rankingColor = UIColor.whiteColor()
            cell?.rankingLabelContainerView.backgroundColor = rankingColor
            cell?.rankingLabel.backgroundColor = rankingColor
            cell?.rankingLabel.textColor = UIColor(red:0, green:0.69, blue:0.45, alpha:1)
        }
        
        
//        if indexPath.row == 0 {
//            let rankingColor = UIColor(red:0, green:0.75, blue:0.45, alpha:1)
//            cell?.rankingLabelContainerView.backgroundColor = rankingColor
//            cell?.rankingLabel.backgroundColor = rankingColor
//            cell?.rankingLabel.textColor = UIColor.whiteColor()
//            cell?.scoreLabel.textColor = APP_THEME_COLOR
//        } else if indexPath.row == 1 {
//            let rankingColor = UIColor(red:0.19, green:0.85, blue:0.66, alpha:1)
//            cell?.rankingLabelContainerView.backgroundColor = rankingColor
//            cell?.rankingLabel.backgroundColor = rankingColor
//            cell?.rankingLabel.textColor = UIColor.whiteColor()
//            cell?.scoreLabel.textColor = APP_THEME_COLOR
//        } else if indexPath.row == 2 {
//            let rankingColor = UIColor(red:0.44, green:0.89, blue:0.74, alpha:1)
//            cell?.rankingLabelContainerView.backgroundColor = rankingColor
//            cell?.rankingLabel.backgroundColor = rankingColor
//            cell?.rankingLabel.textColor = UIColor.whiteColor()
//            cell?.scoreLabel.textColor = APP_THEME_COLOR
//        } else {
//            let rankingColor = UIColor.whiteColor()
//            cell?.rankingLabelContainerView.backgroundColor = rankingColor
//            cell?.rankingLabel.backgroundColor = rankingColor
//            cell?.rankingLabel.textColor = UIColor(red:0, green:0.69, blue:0.45, alpha:1)
//        }

        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        cell?.rankingLabel.text = String(indexPath.row + 1)
        
        //test code
        if indexPath.row == 0 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_1")
            cell?.nameLabel.text = "熊敬开"
            cell?.scoreLabel.text = "715"
            cell?.addScoreLabel.text = "+" + "23"
        }else if indexPath.row == 1 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_2")
            cell?.nameLabel.text = "笑丘"
            cell?.scoreLabel.text = "454"
            cell?.addScoreLabel.text = "+" + "33"
        }else if indexPath.row == 2 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_3")
            cell?.nameLabel.text = "关超"
            cell?.scoreLabel.text = "388"
            cell?.addScoreLabel.text = "+" + "15"
        }else if indexPath.row == 3 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_4")
            cell?.nameLabel.text = "笑丘"
            cell?.scoreLabel.text = "357"
            cell?.addScoreLabel.text = "-" + "29"
        }else if indexPath.row == 4 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_5")
            cell?.nameLabel.text = "关超"
            cell?.scoreLabel.text = "331"
            cell?.addScoreLabel.text = "+" + "12"
        }else if indexPath.row == 5 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_6")
            cell?.nameLabel.text = "笑丘"
            cell?.scoreLabel.text = "324"
            cell?.addScoreLabel.text = "-" + "48"
        }else if indexPath.row == 6 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_7")
            cell?.nameLabel.text = "关超"
            cell?.scoreLabel.text = "121"
            cell?.addScoreLabel.text = "+" + "53"
        }else if indexPath.row == 7 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_8")
            cell?.nameLabel.text = "关超"
            cell?.scoreLabel.text = "121"
            cell?.addScoreLabel.text = "+" + "53"
        }else if indexPath.row == 8 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_9")
            cell?.nameLabel.text = "关超"
            cell?.scoreLabel.text = "121"
            cell?.addScoreLabel.text = "+" + "53"
        }else if indexPath.row == 9 {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_10")
            cell?.nameLabel.text = "关超"
            cell?.scoreLabel.text = "121"
            cell?.addScoreLabel.text = "+" + "53"
        }else {
            cell?.avatarImageView.image = UIImage(named: "testAvatar_3")
            cell?.nameLabel.text = "关超"
            cell?.scoreLabel.text = "121"
            cell?.addScoreLabel.text = "+" + "53"
        }

        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 76
    }
    
    func configUI() {
        self.navigationItem.title = "PING团队"
        self.edgesForExtendedLayout = UIRectEdge.None
        
        //test code
//        let rightItem = UIBarButtonItem(title: "add", style: UIBarButtonItemStyle.Plain, target: self, action: "addReview")
//        rightItem.image = UIImage(named: "add")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//        self.navigationItem.rightBarButtonItem = rightItem
        self.introductionView.hidden = true
    }
    
    
    
    func addReview() {
        let menuView = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH!, 50))
        menuView.backgroundColor = APP_THEME_COLOR
        self.view.addSubview(menuView)
    }
}
