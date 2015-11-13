//
//  UserViewController.swift
//  
//
//  Created by Joshua Xiong on 8/7/15.
//
//

import UIKit

class UserViewController: UIViewController, APICallBackDelegate {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    //Network Operation Queue
    let mainQueue: NSOperationQueue = NSOperationQueue()
    
    var userInfoDataModel:UserInfoModel
    var userPoint:String
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        userInfoDataModel = UserInfoModel(userTel: "", userName: "...", headImgUrl: "")
        userPoint = "-"
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        let nibNameOrNil:String? = "UserViewController"
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let avatarImageViewTapRecognizer = UITapGestureRecognizer(target: self, action: "tapAvatarImageView")
        avatarImage.addGestureRecognizer(avatarImageViewTapRecognizer)
        
        let fetchUserInfoOperation = UserInfoAPIOperation()
        let fetchUserPointOperation = MyPointAPIOperation(action: .year)
        fetchUserPointOperation.delegate = self
        fetchUserInfoOperation.delegate = self
        mainQueue.addOperation(fetchUserInfoOperation)
        mainQueue.addOperation(fetchUserPointOperation)
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
        if Operation.isKindOfClass(UserInfoAPIOperation) {
            let op = Operation as! UserInfoAPIOperation
            userInfoDataModel = op.getUserInfo()
        }
        if Operation.isKindOfClass(MyPointAPIOperation) {
            let op = Operation as! MyPointAPIOperation
            userPoint = op.getUserPoint()
        }
        self.loadData()
    }
    
    func networkOperationErrorHandler() {
        return
    }
    
    
    func tapAvatarImageView() {
        let imagePickerVC = avatarImagePickerViewController()
        self.presentViewController(imagePickerVC, animated: true, completion: nil)
    }

    func logout() {
        APP_DEFULT_STORE.setObject(nil, forKey: kUserToken)
        goToMainVC()
    }
    
    func goToMainVC() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController?.modalTransitionStyle = .CrossDissolve
        let loginVC = LoginAndRegisterViewController(tabBarController: appDelegate.window?.rootViewController as! UITabBarController)
        UIView.transitionWithView(loginVC.view, duration: 0.8, options: .TransitionCrossDissolve, animations: {
            let oldState = UIView.areAnimationsEnabled()
            UIView.setAnimationsEnabled(false)
            appDelegate.configUI()
            UIView.setAnimationsEnabled(oldState)
            }, completion: nil)
        
    }
    
    func loadData() {
        nameLabel.text = userInfoDataModel.userName
        avatarImage.kf_setImageWithURL(NSURL(string: userInfoDataModel.headImgUrl)!, placeholderImage: UIImage(named: "Image_Placeholder"))
        pointLabel.text = userPoint
    }
    
    func configUI() {
        self.loadData()
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.cornerRadius = 15
        let rightItem = UIBarButtonItem(title: "logout", style: UIBarButtonItemStyle.Plain, target: self, action: "logout")
        rightItem.image = UIImage(named: "exit")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.rightBarButtonItem = rightItem
    }
}
