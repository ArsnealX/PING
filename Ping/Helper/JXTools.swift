//
//  JXTools.swift
//  Ping
//
//  Created by Joshua Xiong on 7/28/15.
//  Copyright © 2015 Joshua Xiong. All rights reserved.
//

import UIKit

class JXTools: NSObject {
    class func shakeAnimationForView(view:UIView!) {
        let lbl = view.layer
        let posLbl = lbl.position
        let y = CGPointMake(posLbl.x - 10, posLbl.y)
        let x = CGPointMake(posLbl.x+10, posLbl.y);
        let animation = CABasicAnimation(keyPath: "position")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fromValue = NSValue(CGPoint:x)
        animation.toValue = NSValue(CGPoint:y)
        animation.autoreverses = true
        animation.duration = 0.08
        animation.repeatCount = 3
        lbl .addAnimation(animation, forKey: nil)
    }
    
    class func showPopupView(popupView: UIView!) {
        popupView.alpha = 1.0;
        let popAnimation = CAKeyframeAnimation(keyPath: "transform")
        popAnimation.duration = 0.4
        popAnimation.values = [NSValue(CATransform3D: CATransform3DMakeScale(0.01, 0.01, 1.0)),
                               NSValue(CATransform3D: CATransform3DMakeScale(1.1, 1.1, 1.0)),
                               NSValue(CATransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)),
                               NSValue(CATransform3D: CATransform3DIdentity)]
        popAnimation.keyTimes = [0.2, 0.5, 0.75, 1.0]
        popAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                                        CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                                        CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        popupView.layer.addAnimation(popAnimation, forKey: nil)
    }
    
    class func dismissPopupView(popupView: UIView!) {
        let hideAnimation = CAKeyframeAnimation(keyPath: "transform")
        hideAnimation.duration = 0.4
        hideAnimation.values = [NSValue(CATransform3D: CATransform3DMakeScale(1.1, 1.1, 1.0)),
                               NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)),
                               NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0))]
        hideAnimation.keyTimes = [0.2, 0.5, 0.75]
        hideAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                                         CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                                         CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        hideAnimation.delegate = self
        popupView.layer.addAnimation(hideAnimation, forKey: nil)
    }
    
    class func timestampGenerator() -> String {
        let currentTime = NSDate()
        let timestamp = currentTime.timeIntervalSince1970
        let timestampDouble = round(timestamp)
        let timestampString = NSString(format: "%0.0f", timestampDouble) as String
        print("timestamp is :" + timestampString)
        return timestampString
    }
    
    class func timestampToReadableDate(timestamp:String) -> String {
        let time: NSTimeInterval = (timestamp as NSString).doubleValue
        let date = NSDate(timeIntervalSince1970: time)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM.dd"
        return formatter.stringFromDate(date)
    }
    
    class func cellPhoneNumberValidator(num: NSString) -> Bool {
        let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluateWithObject(num) == true)
            || (regextestcm.evaluateWithObject(num)  == true)
            || (regextestct.evaluateWithObject(num) == true)
            || (regextestcu.evaluateWithObject(num) == true)) {
            return true
        }else {
            return false
        }
    }
    
    class func passwordValidator(password: String) -> Bool {
        if (password as NSString).length >= 6 {
             return true
        }
        return false
    }
}
