//
//  LoginAndRegisterViewController.swift
//  
//
//  Created by Joshua Xiong on 8/11/15.
//
//

import UIKit

class LoginAndRegisterViewController: UIViewController, APICallBackDelegate {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var userInfoTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var titleViewTopSpaceConstraint: NSLayoutConstraint!
    
    var nextBtnStatus:nextButtonStatus!
    var buttonActivityIndicator: UIActivityIndicatorView!
    var mainTabBarController: UITabBarController!
    var phoneNumberString: String?
    var passwordString: String?
    var nickName: String?
    
    enum nextButtonStatus {
        case nextStatus
        case loginStatus
        case registerStatus
        case confirmNicknameStatus
        case registerSuccessStatus
    }
    
    //Network Operation Queue
    let mainQueue: NSOperationQueue = NSOperationQueue()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        buttonActivityIndicator = UIActivityIndicatorView()
        nextBtnStatus = .nextStatus
    }
    
    convenience init(tabBarController:UITabBarController) {
        let nibNameOrNil:String? = "LoginAndRegisterViewController"
        self.init(nibName: nibNameOrNil, bundle: nil)
        mainTabBarController = tabBarController
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        showInfoGatheringComponent()
    }
    
    //MARK:DELEGATE AND DATASOURCE
    
    func networkOperationCompletionHandler(Operation: NetworkOperation) {        
        if Operation.isKindOfClass(AccountIsRegAPIOperation) {
            let op = Operation as! AccountIsRegAPIOperation
            if op.isReg() {
                nextBtnStatus = .registerStatus
            }else {
                nextBtnStatus = .loginStatus
            }
        }else if Operation.isKindOfClass(LoginAPIOperation) {
            let op = Operation as! LoginAPIOperation
            APP_DEFULT_STORE.setObject(op.getToken(), forKey: kUserToken)
            goToMainVC()
        }else if Operation.isKindOfClass(RegisterAPIOperation) {
            let op = Operation as! RegisterAPIOperation
            APP_DEFULT_STORE.setObject(op.getToken(), forKey: kUserToken)
            nextBtnStatus = .confirmNicknameStatus
        }else {
            goToMainVC()
        }
    
        //let activity indicator have more time to display (removeable)
        let time: NSTimeInterval = 0.5
        let delay = dispatch_time(DISPATCH_TIME_NOW,Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
            self.changeButtonStatus()
        }
    }
    
    func networkOperationErrorHandler() {
        changeButtonStatus()
        return
    }
    
    //MARK:EVENT RESPONDER
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        //hide keyboard
        userInfoTextField.endEditing(true)
    }
    
    @IBAction func nextButtonPressed(sender: UIButton) {
        var operation:NetworkOperation
        //TODO:check empty situation of text field
        if nextBtnStatus == .nextStatus {
            //check phone number input
            if JXTools.cellPhoneNumberValidator(userInfoTextField.text!) {
                phoneNumberString = userInfoTextField.text
                operation = AccountIsRegAPIOperation(withPhoneNumber: phoneNumberString!)
            }else {
                JXTools.shakeAnimationForView(userInfoTextField)
                return
            }
        }else if nextBtnStatus == .loginStatus {
            passwordString = userInfoTextField.text
            operation = LoginAPIOperation(withPhoneNumber: phoneNumberString!, password: passwordString!)
        }else if nextBtnStatus == .registerStatus {
            //check password input
            if JXTools.passwordValidator(userInfoTextField.text!) {
                passwordString = userInfoTextField.text
                operation = RegisterAPIOperation(withPhoneNumber: phoneNumberString!, password: passwordString!)
            }else {
                JXTools.shakeAnimationForView(userInfoTextField)
                return
            }
        }else {
            nickName = userInfoTextField.text
            operation = SetUsernameAPIOperation(withUserName: nickName!)
        }
        
        operation.delegate = self
        mainQueue.addOperation(operation)
        showNetworkIndicatorOnButton(sender)
    }

    //MARK:PRIVATE METHOD
    
    func showNetworkIndicatorOnButton(sender: UIButton) {
        buttonActivityIndicator.frame = sender.frame
        buttonActivityIndicator.userInteractionEnabled = true
        userInfoTextField.userInteractionEnabled = false
        buttonActivityIndicator.activityIndicatorViewStyle = .White
        self.view.addSubview(buttonActivityIndicator)
        sender.setTitle("", forState: UIControlState.Normal)
        buttonActivityIndicator.startAnimating()
    }
    
    func removeNetworkIndicator() {
        self.buttonActivityIndicator.stopAnimating()
        self.buttonActivityIndicator.userInteractionEnabled = false
    }
    
    func changeButtonStatus() {
        //keyboard type setting must before user interaction enabling
        if nextBtnStatus == .nextStatus {
            nextButton.setTitle("下一步", forState: UIControlState.Normal)
        }else if nextBtnStatus == .loginStatus {
            nextButton.setTitle("登录", forState: UIControlState.Normal)
            userInfoTextField.placeholder = "请输入密码"
            userInfoTextField.secureTextEntry = true
            userInfoTextField.keyboardType = .Alphabet
        }else if nextBtnStatus == .registerStatus {
            nextButton.setTitle("注册", forState: UIControlState.Normal)
            userInfoTextField.placeholder = "请输入6位或以上的密码"
            userInfoTextField.secureTextEntry = true
            userInfoTextField.keyboardType = .Alphabet
        }else {
            nextButton.setTitle("确认", forState: UIControlState.Normal)
            userInfoTextField.placeholder = "请输入您的姓名"
            userInfoTextField.secureTextEntry = false
            userInfoTextField.keyboardType = .Default
        }
        userInfoTextField.text = ""
        userInfoTextField.userInteractionEnabled = true
        self.removeNetworkIndicator()
    }
    
    func configUI() {
        userInfoTextField.hidden = true
        userInfoTextField.layer.cornerRadius = 3
        userInfoTextField.layer.borderWidth = 0
        userInfoTextField.keyboardType = .PhonePad
        nextButton.hidden = true
        nextButton.layer.masksToBounds = true
        nextButton.layer.cornerRadius = 3
    }
    
    func showInfoGatheringComponent() {
        UIView.animateWithDuration(0.8, animations: {
            self.titleViewTopSpaceConstraint.constant = self.titleViewTopSpaceConstraint.constant - 125
            self.titleView.layoutIfNeeded()
            }, completion:{
                (value: Bool) in
                UIView.transitionWithView(self.userInfoTextField, duration: 0.4, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {}, completion: nil)
                UIView.transitionWithView(self.nextButton, duration: 0.4, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {}, completion: nil)
                self.userInfoTextField.hidden = false
                self.nextButton.hidden = false
                self.userInfoTextField.becomeFirstResponder()
        })
    }
    
    func storeUserInfomation() {
        let userInfoDict = ["account_id":phoneNumberString!, "password":passwordString!.md5]
        APP_DEFULT_STORE.setObject(userInfoDict, forKey: "userInfo")
    }
    
    func goToMainVC() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController?.modalTransitionStyle = .CrossDissolve
        UIView.transitionWithView(appDelegate.window!, duration: 0.8, options: .TransitionCrossDissolve, animations: {
            let oldState = UIView.areAnimationsEnabled()
            UIView.setAnimationsEnabled(false)
            if self.nextBtnStatus == .confirmNicknameStatus || self.nextBtnStatus == .loginStatus {
                self.mainTabBarController.selectedIndex = 1
            }
            appDelegate.window?.rootViewController = self.mainTabBarController
            UIView.setAnimationsEnabled(oldState)
        }, completion: nil)

    }
}
