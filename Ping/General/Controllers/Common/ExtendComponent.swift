//
//  ExtendComponent.swift
//  Ping
//
//  Created by datayes on 16/5/3.
//  Copyright © 2016年 Kejukeji. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addLeftReturnButton() ->Void{
        self.addLeftButtonWithMessage(UIImage(named:"backIcon"), title: nil, actionClick: Selector(leftButtonClick()))
    }
    
    func addLeftButtonWithIcon(image:UIImage?,actionClick:Selector?) ->Void{
        self.addLeftButtonWithMessage(image, title: nil, actionClick: actionClick)
    }

    private func leftButtonClick() -> Void {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    func addLeftButtonWithMessage(image:UIImage?,
                                  title:String?,
                                  actionClick:Selector?) -> Void {
        self.navigationItem.leftBarButtonItem = nil
        if image != nil {
            let button = UIButton(type:.Custom)
             button.frame = CGRectMake(0, 0, 25, 25)
             button.titleLabel?.font = UIFont.systemFontOfSize(15)
            button.setImage(image, forState: UIControlState.Normal)
            if title != nil {
                button.frame = CGRectMake(0, 0, 54, 25)
               button.setTitle(title, forState: UIControlState.Normal)
                button.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0)
            } else {
                button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
            }
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.addTarget(self, action: actionClick!, forControlEvents:  UIControlEvents.TouchUpInside)
            let leftItem = UIBarButtonItem(customView:button)
             self.navigationItem.leftBarButtonItem = leftItem
        } else if title != nil {
            let button = UIButton(type:.Custom)
            button.frame = CGRectMake(0, 0, 44, 25)
            button.backgroundColor = UIColor.clearColor()
            button.titleLabel?.font = UIFont.systemFontOfSize(15)
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0)
            button.setTitle(title, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.addTarget(self, action: actionClick!, forControlEvents:  UIControlEvents.TouchUpInside)
            let leftItem = UIBarButtonItem(customView:button)
            self.navigationItem.leftBarButtonItem = leftItem
        } else {
            self.navigationItem.leftBarButtonItem = nil;
        }
        
    }
}