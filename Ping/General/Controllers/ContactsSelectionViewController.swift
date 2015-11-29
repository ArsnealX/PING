//
//  contactsSelectionViewController.swift
//  Ping
//
//  Created by Joshua Xiong on 7/29/15.
//  Copyright © 2015 Joshua Xiong. All rights reserved.
//

import UIKit

protocol contactsSelectionDelegate: class{
    func selectedContactsArray(selectedArray:Array<TeamMemberModel>)
    func selectedContact(selected:TeamMemberModel)
}

class contactsSelectionViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, APICallBackDelegate {
    @IBOutlet weak var contactsSelectionTableView: UITableView!
    var contactNameDataSourceArray:Array<TeamMemberModel>
    var lastSelectedIndexPath:NSIndexPath!
    var contactNameArray:Array<TeamMemberModel>
    
    weak var selectionDelegate:contactsSelectionDelegate?
    var ifSingleSelection:Bool!
    
    //Network Operation Queue
    let mainQueue: NSOperationQueue = NSOperationQueue()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        contactNameDataSourceArray = [TeamMemberModel]()
        contactNameArray = [TeamMemberModel]()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(ifSS:Bool) {
        let nibNameOrNil:String? = "ContactsSelectionViewController"
        self.init(nibName: nibNameOrNil, bundle: nil)
        self.ifSingleSelection = ifSS
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsSelectionTableView?.registerNib(UINib(nibName: "contactSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "contactSelectionTableViewCell")
        contactsSelectionTableView?.dataSource = self
        contactsSelectionTableView?.delegate = self
        let queryTeamMemberAPIOperation = QueryTeamMemberAPIOperation()
        queryTeamMemberAPIOperation.delegate = self
        mainQueue.addOperation(queryTeamMemberAPIOperation)
        self.pleaseWait()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:DATASOURCE AND DELEGATE
    func networkOperationCompletionHandler(Operation: NetworkOperation) {
        if Operation.isKindOfClass(QueryTeamMemberAPIOperation) {
            let op = Operation as! QueryTeamMemberAPIOperation
            contactNameDataSourceArray = op.getTeamMemberList()
            self.clearAllNotice()
            contactsSelectionTableView.reloadData()
        }
    }
    
    func networkOperationErrorHandler() {
        self.noticeError("出错了!", autoClear: true)
        return
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactNameDataSourceArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "contactSelectionTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? contactSelectionTableViewCell
        cell?.setContent(contactNameDataSourceArray[indexPath.row])
        cell?.selectionStyle = UITableViewCellSelectionStyle.Default
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 59
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !ifSingleSelection {//multiple selection
            let indexPaths = [indexPath]
            if contactNameDataSourceArray[indexPath.row].selected {
                contactNameDataSourceArray[indexPath.row].selected = false
                contactNameArray.removeAtIndex(contactNameDataSourceArray[indexPath.row].index)
            }else {
                contactNameDataSourceArray[indexPath.row].selected = true
                contactNameArray.append(contactNameDataSourceArray[indexPath.row])
                contactNameDataSourceArray[indexPath.row].index = contactNameArray.count - 1
            }
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
        }else {//single selection
            var indexPaths = [indexPath]
            if (lastSelectedIndexPath != nil) {
                contactNameDataSourceArray[lastSelectedIndexPath.row].selected = false
                if indexPath != lastSelectedIndexPath {
                    indexPaths.append(lastSelectedIndexPath)
                }
            }
            contactNameDataSourceArray[indexPath.row].selected = true
            lastSelectedIndexPath = indexPath
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
            contactNameArray.append(contactNameDataSourceArray[indexPath.row])
            self.confirmName()
            self.navigationController?.popViewControllerAnimated(true)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func confirmName() { //single selection
        if ((selectionDelegate) != nil) {
            selectionDelegate?.selectedContact(contactNameArray.last!)
        }
    }
    
    func confirmNames() {
        if ((selectionDelegate) != nil) {
            selectionDelegate?.selectedContactsArray(contactNameArray)
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func configUI() {
        if !ifSingleSelection {
            self.title = "抄送人"
            let rightItem = UIBarButtonItem(title: "confirm", style: UIBarButtonItemStyle.Plain, target: self, action: "confirmNames")
            rightItem.image = UIImage(named: "check")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            self.navigationItem.rightBarButtonItem = rightItem
        }else {
            self.title = "审核人"
        }
        contactsSelectionTableView.tableFooterView = UIView()
        self.edgesForExtendedLayout = UIRectEdge.None
                contactsSelectionTableView?.separatorInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 10)
    }
}
