//
//  PTHistoryController.swift
//  Ping
//
//  Created by zhizhong.zhou on 16/5/5.
//  Copyright © 2016年 Kejukeji. All rights reserved.
//

import UIKit

class PTHistoryController: PTTableViewController,APICallBackDelegate {
    
    var taskListArray:Array<TaskDetailModel> = []
    var taskType:String = "1"
    let mainQueue: NSOperationQueue = NSOperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        
    }
    
    func configUI() {
        self.addNavTitle("历史执办")
        tableView.registerNib(UINib(nibName: "tasksTableViewCell", bundle: nil), forCellReuseIdentifier: "tasksTableViewCell")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        let fetchTaskListOperation = TaskListAPIOperation(withTaskRoleState: self.taskType, startIndex: "0", endIndex: "99");
        
        fetchTaskListOperation.delegate = self
        self.mainQueue.addOperation(fetchTaskListOperation)
    }
    
    func networkOperationCompletionHandler(Operation: NetworkOperation) {
        if Operation.isKindOfClass(TaskListAPIOperation) {
            let op = Operation as! TaskListAPIOperation
            taskListArray = op.getListArray()
            print(op.getListArray())
            tableView .reloadData()
        }
    }
    
    func networkOperationErrorHandler() {
        self.noticeError("出错了!", autoClear: true)
        return
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskListArray.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 76
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "tasksTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? tasksTableViewCell
        cell?.backgroundColor = UIColor.whiteColor()
        cell?.setContent(taskListArray[indexPath.row])
        cell?.selectionStyle = UITableViewCellSelectionStyle.Default
        return cell!
    }
    
}
