//
//  TeamViewController.swift
//  
//
//  Created by Joshua Xiong on 8/7/15.
//
//

import UIKit
import Refresher

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
        
        let getTeamNameOperation = GetTeamNameAPIOperation();
        getTeamNameOperation.delegate = self;
        self.mainQueue.addOperation(getTeamNameOperation)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.configUI()
        let pacmanAnimator = PacmanAnimator(frame: CGRectMake(0, 0, SCREEN_WIDTH!, 80))
        self.verticalGreenLine.hidden = true
        teamRankingTableView.addPullToRefreshWithAction ({
            let fetchTeamRankingOperation = TeamRankAPIOperation()
            fetchTeamRankingOperation.delegate = self
            self.mainQueue.addOperation(fetchTeamRankingOperation)
            }, withAnimator: pacmanAnimator)
        teamRankingTableView.startPullToRefresh()
    }
    
    //MARK:DATASOURCE AND DELEGATE
    func networkOperationCompletionHandler(Operation: NetworkOperation) {
        if Operation.isKindOfClass(TeamRankAPIOperation) {
            let op = Operation as! TeamRankAPIOperation
            teamRankingArray = op.getTemaRank()
            teamRankingArray = teamRankingArray.sort{Int($0.yearPoint) > Int($1.yearPoint)}
            teamRankingTableView.stopPullToRefresh()
            reloadTableView()
        }
        
        if Operation.isKindOfClass(GetTeamNameAPIOperation) {
            let op = Operation as! GetTeamNameAPIOperation
            if  let title = APP_DEFULT_STORE.objectForKey(kTeamName) {
                if op.getTeamName() != title as? String {
                    self.navigationItem.title = op.getTeamName()
                    APP_DEFULT_STORE.setObject(op.getTeamName(), forKey: kTeamName)
                }
            }else  {
                self.navigationItem.title = op.getTeamName()
                APP_DEFULT_STORE.setObject(op.getTeamName(), forKey: kTeamName)
            }
        }
    }
    
    func networkOperationErrorHandler() {
        teamRankingTableView.stopPullToRefresh()
        self.noticeError("出错了!", autoClear: true)
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
        if  let title = APP_DEFULT_STORE.objectForKey(kTeamName) {
            self.navigationItem.title = title as? String
        }else {
            self.navigationItem.title = "PING"
        }
        self.edgesForExtendedLayout = UIRectEdge.None
        
        //v2.0 function
//        let rightItem = UIBarButtonItem(title: "add", style: UIBarButtonItemStyle.Plain, target: self, action: "addReview")
//        rightItem.image = UIImage(named: "add")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//        self.navigationItem.rightBarButtonItem = rightItem
        self.introductionView.hidden = true
        let footView = UIView();
        footView.backgroundColor = UIColor.clearColor()
        teamRankingTableView.tableFooterView = footView
    }
    
    func reloadTableView() {
        teamRankingTableView.reloadData()
        if  teamRankingArray.count > 0 {
            self.verticalGreenLine.hidden = false
        }else {
            self.verticalGreenLine.hidden = true
        }
    }
    
    
    func addReview() {
        let menuView = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH!, 50))
        menuView.backgroundColor = APP_THEME_COLOR
        self.view.addSubview(menuView)
    }
}
