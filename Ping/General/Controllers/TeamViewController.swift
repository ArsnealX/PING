//
//  TeamViewController.swift
//  
//
//  Created by Joshua Xiong on 8/7/15.
//
//

import UIKit

class TeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APICallBackDelegate {
    @IBOutlet weak var teamRankingTableView: UITableView!
    @IBOutlet weak var verticalGreenLine: UIImageView!
    @IBOutlet weak var introductionView: UIView!
    
    var teamRankingArray:Array<TeamRankingModel>
    
    //Network Operation Queue
    let mainQueue: NSOperationQueue = NSOperationQueue()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        teamRankingArray = [TeamRankingModel]()
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
        let fetchTeamRankingOperation = TeamRankAPIOperation()
        fetchTeamRankingOperation.delegate = self
        mainQueue.addOperation(fetchTeamRankingOperation)
        
    }
    
    //MARK:DATASOURCE AND DELEGATE
    func networkOperationCompletionHandler(Operation: NetworkOperation) {
        if Operation.isKindOfClass(TeamRankAPIOperation) {
            let op = Operation as! TeamRankAPIOperation
            teamRankingArray = op.getTemaRank()
            teamRankingArray = teamRankingArray.sort{Int($0.weekPoint) > Int($1.weekPoint)}
            teamRankingTableView.reloadData()
        }
    }
    
    func networkOperationErrorHandler() {
        return
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamRankingArray.count
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

        cell?.setContent(teamRankingArray[indexPath.row])
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        cell?.rankingLabel.text = String(indexPath.row + 1)
        
        
        //demo code
//        DemoCode.TeamViewControllerDemoCode(cell, indexPath: indexPath)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 76
    }
    
    func configUI() {
        self.navigationItem.title = "PING团队"
        self.edgesForExtendedLayout = UIRectEdge.None
        
        //v2.0 function
//        let rightItem = UIBarButtonItem(title: "add", style: UIBarButtonItemStyle.Plain, target: self, action: "addReview")
//        rightItem.image = UIImage(named: "add")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//        self.navigationItem.rightBarButtonItem = rightItem
        self.introductionView.hidden = true
        teamRankingTableView.tableFooterView = UIView()
    }
    
    
    
    func addReview() {
        let menuView = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH!, 50))
        menuView.backgroundColor = APP_THEME_COLOR
        self.view.addSubview(menuView)
    }
}
