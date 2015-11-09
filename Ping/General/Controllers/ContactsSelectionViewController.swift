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
    var contactNameDataSorceArray:Array<TeamMemberModel>
    var lastSelectedIndexPath:NSIndexPath!
    var contactNameArray:Array<TeamMemberModel>
    
    weak var selectionDelegate:contactsSelectionDelegate?
    var ifSingleSelection:Bool!
    
    //Network Operation Queue
    let mainQueue: NSOperationQueue = NSOperationQueue()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        contactNameDataSorceArray = [TeamMemberModel]()
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
            contactNameDataSorceArray = op.getTeamMemberList()
            contactsSelectionTableView.reloadData()
        }
    }
    
    func networkOperationErrorHandler() {
        return
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactNameDataSorceArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "contactSelectionTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? contactSelectionTableViewCell
        cell?.setContent(contactNameDataSorceArray[indexPath.row])
        cell?.selectionStyle = UITableViewCellSelectionStyle.Default
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 59
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !ifSingleSelection {
            configSelectionStyleForTableViewAtIndexPath(tableView, indexPath: indexPath)
        }else {//single selection
            configSelectionStyleForTableViewAtIndexPath(tableView, indexPath: indexPath)
            if (lastSelectedIndexPath != nil) {
                let lastCell = tableView.cellForRowAtIndexPath(lastSelectedIndexPath) as? contactSelectionTableViewCell
                let lastSelectionStatus = (lastCell?.isCellSelected)!
                if lastSelectionStatus {
                    lastCell?.checkMarkImageView.hidden = true
                    lastCell?.isCellSelected = false
                }
            }
            lastSelectedIndexPath = indexPath
            self.confirmName()
            self.navigationController?.popViewControllerAnimated(true)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func configSelectionStyleForTableViewAtIndexPath(tableView: UITableView, indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as?contactSelectionTableViewCell
        let selectionStatus = (cell?.isCellSelected)!
        if !selectionStatus {
            cell?.checkMarkImageView.hidden = false
            cell?.isCellSelected = true
            contactNameArray.append(contactNameDataSorceArray[indexPath.row])
        }else {
            cell?.checkMarkImageView.hidden = true
            cell?.isCellSelected = false
        }
    }
    
    func confirmName() { //single selection
        if ((selectionDelegate) != nil) {
            selectionDelegate?.selectedContact(contactNameArray.first!)
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
        self.edgesForExtendedLayout = UIRectEdge.None
                contactsSelectionTableView?.separatorInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 10)
    }
}
