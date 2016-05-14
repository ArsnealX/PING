//
//  PTInputView.swift
//  Ping
//
//  Created by zhizhong.zhou on 16/5/14.
//  Copyright © 2016年 Kejukeji. All rights reserved.
//

import UIKit


class PTInputView: UIImageView ,UITextFieldDelegate{

    var textField:UITextField?
    var delegate : YTInputViewDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        self.image = UIImage.init(named: "chat_bottom_bg")
        let soundBtn = UIButton(type: UIButtonType.Custom)
        let  btnBackImage = UIImage.init(named: "chat_bottom_voice_nor")
        let  image2 = UIImage.init(named: "chat_bottom_voice_press")
        
        soundBtn.setBackgroundImage(btnBackImage, forState: UIControlState.Normal)
        soundBtn.setBackgroundImage(image2, forState: UIControlState.Highlighted)
        soundBtn.frame = CGRectMake(0, 0, 44, 44)
        self.addSubview(soundBtn)

        let textFieldBackImageView = UIImageView()
        textFieldBackImageView.frame = CGRectMake(CGRectGetMaxX(soundBtn.frame),0,PTScreenWidth - 3 * 44 - 5,30)
        textFieldBackImageView.userInteractionEnabled = true
        textFieldBackImageView.center = CGPointMake(textFieldBackImageView.center.x, self.frame.size.height / 2);
        textFieldBackImageView.image = UIImage.init(named:"chat_bottom_textfield")
        
        let textField = UITextField.init(frame:CGRectMake(0,
            0,
            textFieldBackImageView.frame.size.width - 10,
            textFieldBackImageView.frame.size.height - 10))
        self.textField = textField
        textField.center = CGPointMake(textFieldBackImageView.frame.size.width / 2,
                                       textFieldBackImageView.frame.size.height / 2)
        textField.returnKeyType = UIReturnKeyType.Send
        //当输入框没有内容的时候 return键自动设置位不能点击的状态
        textField.enablesReturnKeyAutomatically = true
        textField.delegate = self
        textFieldBackImageView.addSubview(textField)

        self.addSubview(textFieldBackImageView)

        let titleArray = ["chat_bottom_up", "chat_bottom_smile"]
        for i in 0 ..< 2  {
            let btn = UIButton(type: UIButtonType.Custom)
            let  image1 = UIImage.init(named: titleArray[i]+"_nor")
            let  imageHigh = UIImage.init(named: titleArray[i]+"_press")
            btn.setImage(image1, forState: UIControlState.Normal)
            btn.setImage(imageHigh, forState: UIControlState.Highlighted)
            let temp:CGFloat = CGFloat.init(integerLiteral: i)
            btn.frame = CGRectMake((PTScreenWidth - (temp + 1) * 44), 0, 44, 44)
            self.addSubview(btn)
          }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PTInputView.keyboardWillShow), name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PTInputView.keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)

        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     *  是否在输入状态
     */
    func isEditing()->Bool {
        return (self.textField?.isFirstResponder())!
    }
 
    /**
     *  进入输入状态
     */
     func becomeFirstResponder1() -> Bool {
            return (self.textField?.becomeFirstResponder())!
     }
    
    func keyboardWillShow(notification:NSNotification) -> Void {
        let keyboardFrame = notification.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue()
        let time1 = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey]!
        let height =  Float( keyboardFrame.size.height)
             self.delegate.inputViewWillShowKeyboardHeight(self, height: height, time: time1 as! NSNumber)
     }
    func keyboardWillHide(notification:NSNotification) -> Void {
        let time1 = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey]!
             self.delegate.willHideKeyboardWithInputView(self, time: time1 as! NSNumber)
     }
 
//- UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
         self.delegate.inputViewWithText(self, text: textField.text!)
         return true
    }
 
}
