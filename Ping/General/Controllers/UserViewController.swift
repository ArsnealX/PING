//
//  UserViewController.swift
//  
//
//  Created by Joshua Xiong on 8/7/15.
//
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
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
        nameLabel.text = "熊一"
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.cornerRadius = 15
        let avatarImageViewTapRecognizer = UITapGestureRecognizer(target: self, action: "tapAvatarImageView")
        avatarImage.addGestureRecognizer(avatarImageViewTapRecognizer)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let rightItem = UIBarButtonItem(title: "logout", style: UIBarButtonItemStyle.Plain, target: self, action: "logout")
        rightItem.image = UIImage(named: "exit")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}
