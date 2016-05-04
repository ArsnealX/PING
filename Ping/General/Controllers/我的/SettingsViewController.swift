//
//  SettingsViewController.swift
//  Ping
//
//  Created by Joshua Xiong on 12/31/15.
//  Copyright © 2015 Kejukeji. All rights reserved.
//

import UIKit
protocol SettingsViewControllerDelegate: class {
    func didChangeUsername(username: String)
}

class SettingsViewController: UIViewController, APICallBackDelegate{

    var userName:String = ""
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameTextFieldContainerView: UIView!

    weak var delegate: SettingsViewControllerDelegate?
    
    //Network Operation Queue
    let mainQueue: NSOperationQueue = NSOperationQueue()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(withName username:String) {
        let nibNameOrNil:String? = "SettingsViewController"
        self.init(nibName: nibNameOrNil, bundle: nil)
        userName = username
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.text = userName
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.configUI()
    }
    
    //MARK:DELEGATE AND DATASOURCE
    func networkOperationCompletionHandler(Operation: NetworkOperation) {
        if Operation.isKindOfClass(SetUsernameAPIOperation) {
            self.clearAllNotice()
            self.delegate?.didChangeUsername(usernameTextField.text!)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func networkOperationErrorHandler() {
        self.noticeError("出错了!", autoClear: true)
        return
    }
    
    //MARK:EVENT RESPONDER
    func confirm() {
        if usernameTextField.text?.characters.count > 0 {
            let operation = SetUsernameAPIOperation(withUserName: usernameTextField.text!)
            operation.delegate = self
            mainQueue.addOperation(operation)
            self.pleaseWait()
        }else {
            JXTools.shakeAnimationForView(usernameTextFieldContainerView)
        }
        // Do any additional setup after loading the view.
    }

    
    //MARK:PRIVATE METHOD
    func configUI() {
        self.title = "设置"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        let rightItem = UIBarButtonItem(title: "confirm", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SettingsViewController.confirm))
        rightItem.image = UIImage(named: "check")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.rightBarButtonItem = rightItem
    }
}
