//
//  MainViewController.swift
//  
//
//  Created by Joshua Xiong on 6/17/15.
//
//

import UIKit
import Refresher

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APICallBackDelegate {
    @IBOutlet weak var tasksTableView: UITableView!
    
    var taskListArray:Array<TaskDetailModel>
    var taskType:String = "1"
    var pageIndex:Int = 1
    let emptyImageView = UIImageView(frame:CGRectMake(0, 0, 180, 120))
    
    //network reachability
    var isNetworkReachable:Bool!
    
    //Network Operation Queue
    let mainQueue: NSOperationQueue = NSOperationQueue()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        taskListArray = [TaskDetailModel]()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged:", name: reachabilityDidChangeNotification, object: nil)
        isNetworkReachable = true
    }
    
    convenience init(withType type:String, index:Int) {
        let nibNameOrNil:String? = "MainViewController"
        self.init(nibName: nibNameOrNil, bundle: nil)
        taskType = type
        pageIndex = index
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configUI()
        showNetworkStatus()
        let pacmanAnimator = PacmanAnimator(frame: CGRectMake(0, 0, SCREEN_WIDTH!, 80))
        tasksTableView.addPullToRefreshWithAction ({
            let fetchTaskListOperation = TaskListAPIOperation(withTaskRoleState: self.taskType, startIndex: "0", endIndex: "99");
            fetchTaskListOperation.delegate = self
            self.mainQueue.addOperation(fetchTaskListOperation)
            
            }, withAnimator: pacmanAnimator)
        tasksTableView.startPullToRefresh()
    }
    
    //MARK:DELEGATE AND DATASOURCE
    
    func networkOperationCompletionHandler(Operation: NetworkOperation) {        
        if Operation.isKindOfClass(TaskListAPIOperation) {
            let op = Operation as! TaskListAPIOperation
            taskListArray = op.getListArray()
            print(op.getListArray())
            tasksTableView.stopPullToRefresh()
            reloadTableView()
        }
    }
    
    func networkOperationErrorHandler() {
        tasksTableView.stopPullToRefresh()

        self.noticeError("出错了!", autoClear: true)
        return
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskListArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "tasksTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? tasksTableViewCell
        cell?.setContent(taskListArray[indexPath.row])
        cell?.selectionStyle = UITableViewCellSelectionStyle.Default
        
//        Demo Code
//        DemoCode.MainViewControllerDemoCode(cell, indexPath: indexPath)
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let taskId = taskListArray[indexPath.row].taskID
        let reviewDetailVC = reviewDetailViewController(taskId: taskId)
        reviewDetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(reviewDetailVC, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //MARK:EVENT RESPONDER
        
    func reachabilityStatusChanged(notification: NSNotification) {
        if let info = notification.userInfo {
            if let s = info[reachabilityNotificationStatusItem] {
                print(s.description)
                print(s)
                if s.description == "NotReachable" {
                    isNetworkReachable = false
                }else {
                    isNetworkReachable = true
                }
            }
        }
        showNetworkStatus()
    }
    
    func networkReachabilityTip() {
        let alertView = UIAlertView.init(title: "提示", message: "请检查您的网络连接", delegate: nil, cancelButtonTitle: "知道了")
        alertView.show()
    }
    
    //MARK:PRIVATE METHOD
    
    func showNetworkStatus() {
        //uiview animation will complete when user touch home button . put a notification to applicationWillEnterForeground() and set this function as the selector to the notification observer
        hideNetworkErrorIndicator()
        if isNetworkReachable == false {
            showNetworkErrorIndicator()
        }
    }

    func showNetworkErrorIndicator() {
        let networkErrorButton = UIButton(frame: CGRectMake(0, 0, 25, 25))
        networkErrorButton.setImage(UIImage(named: "disconnect")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState:.Normal)
        networkErrorButton.addTarget(self, action: "networkReachabilityTip", forControlEvents: UIControlEvents.TouchUpInside)
        let leftItem = UIBarButtonItem(customView: networkErrorButton)
        self.navigationItem.leftBarButtonItem = leftItem
        UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: [UIViewKeyframeAnimationOptions.AllowUserInteraction, UIViewKeyframeAnimationOptions.Autoreverse, UIViewKeyframeAnimationOptions.Repeat] , animations: {
                networkErrorButton.alpha = 0.1
            }, completion: nil)
    }
    
    func hideNetworkErrorIndicator() {
        self.navigationItem.leftBarButtonItem = nil
    }

    func configUI() {
        self.navigationItem.title = "PING"
        self.edgesForExtendedLayout = UIRectEdge.None
        tasksTableView.registerNib(UINib(nibName: "tasksTableViewCell", bundle: nil), forCellReuseIdentifier: "tasksTableViewCell")
        tasksTableView.separatorInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 10)
        //hide rest separate lines
        tasksTableView.tableFooterView = UIView()
        showEmptyStatusView()
    }
    
    func reloadTableView() {
        tasksTableView.reloadData()
        if taskListArray.count == 0 {
            emptyImageView.hidden = false
        }else {
            emptyImageView.hidden = true
        }
    }
    
    func showEmptyStatusView() {
        emptyImageView.kf_setImageWithURL(NSURL(), placeholderImage: UIImage(named: "emtpyStatus"))
        emptyImageView.center = CGPointMake(SCREEN_WIDTH! / 2, SCREEN_HEIGHT! / 2 - 85);
        emptyImageView.hidden = true
        self.view.addSubview(emptyImageView)
    }
    
}
