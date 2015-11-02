//
//  addReviewViewController.swift
//  Ping
//
//  Created by Joshua Xiong on 7/27/15.
//  Copyright © 2015 Joshua Xiong. All rights reserved.
//

import UIKit

class addReviewViewController: UIViewController, UITextViewDelegate, UIScrollViewDelegate, contactsSelectionDelegate, ratingViewControllerDelegate {
    //审核人label
    @IBOutlet weak var reviewerNameLabel: UILabel!
    @IBOutlet weak var reviewerNameLabelContainer: UIView!
    //抄送人label
    @IBOutlet weak var ccNamesLabel: UILabel!
    @IBOutlet weak var ccNameLabelContainer: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var wordsCountLabel: UILabel!
    @IBOutlet weak var textViewPlaceholderLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textViewContainer: UIView!
    
    
    @IBOutlet weak var wordsCountLabelSpaceToBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollViewSpaceToBottomConstraint: NSLayoutConstraint!
    
    let maxWords = 100
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        let nibNameOrNil:String? = "AddReviewViewController"
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let reviewerNameLabelTapGestrueRecognizer = UITapGestureRecognizer(target: self, action: "tapReviewerNameLabel")
        let ccNameLabelTapGestrueRecognizer = UITapGestureRecognizer(target: self, action: "tapCCNameLabel")
        reviewerNameLabelContainer.addGestureRecognizer(reviewerNameLabelTapGestrueRecognizer)
        ccNameLabelContainer.addGestureRecognizer(ccNameLabelTapGestrueRecognizer)
        contentTextView?.delegate = self
        scrollView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.configUI()
        self.setupNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeNotifications()
    }
    
    //MARK:DELEGATE AND DATASOURCE
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        //复制粘贴时隐藏站位文字
        if (text as NSString).length > 0 {
            textViewPlaceholderLabel.hidden = true
        }
        //----textView字数限制（支持粘帖）
        //将textView已有字符与新增字符拼接成新字符串
        let newString = (textView.text as NSString).stringByReplacingCharactersInRange(range, withString: text)
        //计算新字符串长度与最大字符数限制的差值
        let res = maxWords - (newString as NSString).length
        if res >= 0 {
            return true
        }else {
            //超出字数限制
            //计算新字符串从开始到达到限制的范围时的index
            let endIndex: String.Index = text.startIndex.advancedBy((text as NSString).length + res)
            //按照范围截取新字符串
            let newReplacementText = text.substringToIndex(endIndex)
            //将新截取字符串添加到textView中
            textView.text = (textView.text as NSString).stringByReplacingCharactersInRange(range, withString: newReplacementText)
            //晃动视图，提示用户达到字符限制
            JXTools.shakeAnimationForView(textView as UIView)
            wordsCountLabel.text = "0"
            return false
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        //暴力添加textView的placeholder
        if (textView.text as NSString).length == 0 {
            textViewPlaceholderLabel.hidden = false
        }else {
            textViewPlaceholderLabel.hidden = true
        }
        //剩余字数统计
        let leftWords = maxWords - (textView.text as NSString).length
        wordsCountLabel.text = String(leftWords)
    }
    
    func selectedContactsArray(wordArray:NSMutableArray) {
        
    }
    
    func selectedContact(word:String) {
        reviewerNameLabel.text = word
    }
    
    func didCompleteRating() {
        closeReview()
    }
    
    //MARK:EVENT RESPONDER
    
    func  sendReview() {
        let ratingVC = ratingViewController()
        ratingVC.delegate = self
        ratingVC.view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        self.presentViewController(ratingVC, animated: false, completion: nil)
    }
    
    func closeReview() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tapReviewerNameLabel() {
        let contactsSelectionVC = contactsSelectionViewController(ifSS: true)
        contactsSelectionVC.selectionDelegate = self
        self.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(contactsSelectionVC, animated: true)
    }
    
    func tapCCNameLabel() {
        let contactsSelectionVC = contactsSelectionViewController(ifSS: false)
        contactsSelectionVC.selectionDelegate = self
        self.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(contactsSelectionVC, animated: true)
    }
    
    func keyboardWasShown(aNotification:NSNotification) {
        self.moveTextViewForKeyboard(aNotification, up: true)
        //将scrollView滑动到输入焦点位置
        scrollView.setContentOffset(CGPointMake(0, textViewContainer.frame.origin.y +                 contentTextView.caretRectForPosition(contentTextView.selectedTextRange!.start).origin.y - 16.0), animated: false)
    }
    
    func keyboardWillBeHidden(aNotification:NSNotification) {
        self.moveTextViewForKeyboard(aNotification, up: false)
    }
    
    //MARK:PRIVATE METHOD
    func configUI() {
        self.title = "工作结果"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        wordsCountLabel.layer.masksToBounds = true
        wordsCountLabel.layer.cornerRadius = 18
        //add send button to navigation bar
        let rightItem = UIBarButtonItem(title: "send", style: UIBarButtonItemStyle.Plain, target: self, action: "sendReview")
        rightItem.image = UIImage(named: "send")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.rightBarButtonItem = rightItem
        //add cancal button to navigation bar
        let leftItem = UIBarButtonItem(title: "close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeReview")
        leftItem.image = UIImage(named: "close")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.leftBarButtonItem = leftItem
        
        //scrollView setting
        //键盘隐藏模式(.Interactive和.Drag)
        scrollView.keyboardDismissMode = .Interactive
        //计算textView的高度
        let textViewHeight = self.view.frame.size.height - textViewContainer.frame.origin.y - NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT - 16 //16是textView与其container的下边距与container与scrollview下边距的和
        if textViewHeight > 200 {
            textViewHeightConstraint.constant = textViewHeight
        }
        //让textView随内容增多而增高
        contentTextView.layoutIfNeeded()
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillBeHidden:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func removeNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func moveTextViewForKeyboard(aNotification:NSNotification, up:Bool) {
        //从键盘通知获取键盘高度
        let userInfo = aNotification.userInfo
        let keyboardEndFrameValue = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardEndFrame = keyboardEndFrameValue.CGRectValue()
        let keyboardFrame = self.view.convertRect(keyboardEndFrame, toView: nil)
        //字符统计标签位置
        wordsCountLabelSpaceToBottomConstraint.constant = (up ? keyboardFrame.size.height + 8 : 8)
        //将scrollview缩小至键盘与navigationbar之间
        scrollViewSpaceToBottomConstraint.constant = (up ? keyboardFrame.size.height : 8)
    }
}
