//
//  PTPlanViewController.swift
//  Ping
//
//  Created by zhizhong.zhou on 16/5/15.
//  Copyright © 2016年 Kejukeji. All rights reserved.
//

import UIKit

class PTPlanViewController: PTViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.colorWithRGB(8.0, green: 187.0, blue: 86.0)
        self.creatTopView()
        self.creatTableView()
    }
    
    func creatTopView() -> Void {
        let view:UIView = UIView()
        view.frame = CGRect(x: 0,y: 0,width: PTScreenWidth,height: 64)
        view.backgroundColor = UIColor.colorWithRGB(28, green: 129, blue: 76)
        
        let titleLabel:UILabel = UILabel()
        titleLabel.textAlignment = NSTextAlignment.Left
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.clipsToBounds = true
        titleLabel.frame = CGRect(x: 10,y: 30,width: 100,height: 20)
         titleLabel.text = "备忘/计划"
        view.addSubview(titleLabel)
        
        let contentBtn = UIButton(type: UIButtonType.Custom)
        contentBtn.setImage(UIImage.init(named: "close"), forState: UIControlState.Normal)
        contentBtn.frame = CGRect(x: PTScreenWidth - 40,y: 15,width: 40,height: 40)
        contentBtn.addTarget(self, action: #selector(PTIMViewController.rightButtonClick), forControlEvents: UIControlEvents.TouchDown)
        view.addSubview(contentBtn)
        self.view.addSubview(view)
        
    }
    
    func creatTableView() -> Void {
        let tableView1 = UITableView.init(frame: CGRectMake(40, 100, PTScreenWidth - 80, 200), style: UITableViewStyle.Plain)
        tableView1.backgroundColor = UIColor.redColor()
        
        self.tableView = tableView1
        tableView1.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ChatCell")
        tableView1.layer.cornerRadius = 5
        tableView1.clipsToBounds = true
        tableView1.backgroundColor = UIColor.colorWithRGB(221, green: 221, blue: 221)
        tableView1.dataSource = self
        tableView1.delegate = self
        tableView1.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(tableView1)
    }
    
    func rightButtonClick() -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleLabel:UILabel = UILabel()
        titleLabel.textAlignment = NSTextAlignment.Left
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.clipsToBounds = true
        titleLabel.frame = CGRect(x: 0,y: 0,width: 100,height: 20)
        titleLabel.backgroundColor = UIColor.colorWithRGB(221, green: 221, blue: 221)
        
        titleLabel.text = "备忘"
        return titleLabel
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let contentBtn = UIButton(type: UIButtonType.Custom)
        contentBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        contentBtn.titleLabel!.font = UIFont.systemFontOfSize(15)
        contentBtn.setTitle("增加", forState: UIControlState.Normal)
        contentBtn.backgroundColor = UIColor.colorWithRGB(221, green: 221, blue: 221)
        contentBtn.frame = CGRect(x: 0,y: 0,width: tableView.frame.size.width,height: 40)
        return contentBtn
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath)
        cell.textLabel?.text = "aaa"
        return cell
    }
    
}
