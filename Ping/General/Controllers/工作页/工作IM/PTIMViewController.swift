//
//  PTIMViewController.swift
//  Ping
//
//  Created by zhizhong.zhou on 16/5/14.
//  Copyright © 2016年 Kejukeji. All rights reserved.
//

import UIKit

class PTIMViewController: PTViewController,UITableViewDelegate,UITableViewDataSource,YTInputViewDelegate {
    
    var inputView1:PTInputView!
    var tableView:UITableView!
    var topLabel:UILabel!
    
    var dataArray:Array<PTChatFrameModel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavTitle("工作XXX(3)")
        self.addRifhtButtonWithIcon(UIImage.init(named: "white"), actionClick: #selector(PTIMViewController.rightButtonClick))
        self.automaticallyAdjustsScrollViewInsets = false
        self.createTableView()
        self.createBottomView()
        self.creatTopView()
    }
    
    func rightButtonClick() -> Void {
        let storyBoard = UIStoryboard(name: "PTWorkDetailController",bundle: nil)
        let newVC = storyBoard.instantiateViewControllerWithIdentifier("PTWorkDetailController") as! PTWorkDetailController
        self.navigationController?.pushViewController(newVC, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func creatTopView() -> Void {
        let topView = UILabel.init(frame: CGRect(x: 0,y: 64,width: PTScreenWidth,height: 30))
        topView.backgroundColor = UIColor.colorWithRGB(243, green: 215, blue: 187)
        topView.alpha = 0.4
        topView.textAlignment = NSTextAlignment.Center
        topView.textColor = UIColor.whiteColor()
        self.topLabel = topView
        self.view .addSubview(topView)
        topView.hidden = true
    }
    func showTopToast(text:String) -> Void {
        topLabel.text = text
        topLabel.hidden = false
        let delayInSeconds = 3.0
        let popTime = dispatch_time(DISPATCH_TIME_NOW,
                                    Int64(delayInSeconds * Double(NSEC_PER_SEC))) // 1
        dispatch_after(popTime, dispatch_get_main_queue()) {
            self.topLabel.hidden = true
        }
    }
    func createBottomView() -> Void {
        let bottom = PTInputView.init(frame: CGRectMake(0, PTScreenHeight - 44, PTScreenWidth, 44))
        self.inputView1 = bottom
        bottom.backgroundColor = UIColor.redColor()
        bottom.delegate = self
        self.view.addSubview(self.inputView1)
        
    }
    func createTableView()->Void {
        let tableView1 = UITableView.init(frame: CGRectMake(0, 64, PTScreenWidth, PTScreenHeight - 88 - 20), style: UITableViewStyle.Plain)
        tableView1.backgroundColor = UIColor.redColor()
        
        self.tableView = tableView1
        tableView1.registerClass(PTChatCell.self, forCellReuseIdentifier: "ChatCell")
        tableView1.backgroundColor = UIColor.whiteColor()
        tableView1.dataSource = self
        tableView1.delegate = self
        tableView1.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(tableView1)
        if self.dataArray.count > 0 {
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: (self.dataArray.count - 1)  , inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            
        }
    }
    
    func inputViewWillShowKeyboardHeight(inputView: PTInputView, height: Float, time: NSNumber) {
        if (height == 0) {
            return;
        }
        UIView.animateWithDuration(0.25, animations: {
            self.tableView.frame = CGRectMake(0, 64 + CGFloat(height), PTScreenWidth, PTScreenHeight - 88 - 20 - CGFloat(height))
            self.view.frame = CGRectMake(0, CGFloat(-height), PTScreenWidth,PTScreenHeight)
            self.topLabel.frame = CGRect(x: 0,y: 64 + CGFloat(height),width: PTScreenWidth,height: 30)
        })
    }
    
    func willHideKeyboardWithInputView(inputView: PTInputView, time: NSNumber) {
        UIView.animateWithDuration(0.25, animations: {
            self.tableView.frame =  CGRectMake(0, 64, PTScreenWidth, PTScreenHeight - 88 - 20)
            self.topLabel.frame = CGRect(x: 0,y: 64,width: PTScreenWidth,height: 30)
            self.view.frame = CGRectMake(0, 0, PTScreenWidth, PTScreenHeight);
        })
    }
    
    func inputViewWithText(inputView: PTInputView, text: String) {
        let number:NSNumber = 0
        self.sendText(text, type: number)
        let num1:NSNumber = 1
        let num2:NSNumber = 2
        self.sendText("好的", type: num1)
        self.sendText("好的啊", type: num2)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.dataArray[indexPath.row].cellHeight
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as! PTChatCell
        cell.frameModel = self.dataArray[indexPath.row]
        return cell
    }
    
    /**
     *  模拟发送信息
     *
     *  @param text 要发送的消息
     */
    func sendText(text:String,type:NSNumber) -> Void {
        let date = NSDate()
        let formatter = NSDateFormatter.init()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let nowStr = formatter.stringFromDate(date)
        let nowDate = formatter.dateFromString(nowStr)
        //
        let chatModel = PTChatModel()
        chatModel.text = text
        chatModel.time = formatter.stringFromDate(nowDate!)
        if self.dataArray.count > 0 {
            let lastModel = self.dataArray.last?.chatModel
            let lastDate = formatter.dateFromString((lastModel?.time)!)
            let interval = nowDate?.timeIntervalSinceDate(lastDate!)
            if (interval < Double(1200)) {
                chatModel.hiddenTime = true
            } else {
                chatModel.hiddenTime = false
            }
        }
        chatModel.type = type
        let frameModel = PTChatFrameModel()
        frameModel.chatModel = chatModel
        self.dataArray.append(frameModel)
        let indexPath = NSIndexPath(forRow: (self.dataArray.count - 1)  , inSection: 0)
        self.tableView?.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
        self.tableView?.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    let lastposition:CGFloat = 0
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let  currentPostion = scrollView.contentOffset.y
        if (currentPostion - lastposition > 100) {//up
            self.inputView1.becomeFirstResponder1()
            
        } else if (currentPostion - lastposition < -100){//down
            self.inputView1.textField?.resignFirstResponder()
            
        }
        //        if ((self.inputView1.isEditing())||( scrollView.contentOffset.y - (scrollView.contentSize.height - PTScreenHeight) <= 200)){
        //             return
        //        }
        //                    self.inputView1.becomeFirstResponder1()
        //    }
        
    }
}
