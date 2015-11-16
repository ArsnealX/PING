//
//  PTools.swift
//  Ping
//
//  Created by Joshua Xiong on 9/21/15.
//  Copyright © 2015 Joshua Xiong. All rights reserved.
//

import UIKit

class PTools: NSObject {
    //config navigation bar style
    class func configNavigationController(navController : UINavigationController, tabBarIconName : String?, needTabBar: Bool) {
        //navigation bar title style
        let titleColor = UIColor.whiteColor()
        let textAttributeDict = NSDictionary(objects: [titleColor,APP_NAV_FONT!], forKeys: [NSForegroundColorAttributeName,NSFontAttributeName])
        navController.navigationBar.titleTextAttributes = textAttributeDict as? [String : AnyObject]
        //navigation bar background style
        navController.navigationBar.barTintColor = APP_THEME_COLOR
        navController.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        //tab bar button image
        if needTabBar {
            navController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
            navController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 20)
            navController.tabBarItem.selectedImage = UIImage(named: tabBarIconName!)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            navController.tabBarItem.image = UIImage(named: tabBarIconName!+"_white")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        }
    }
    
    //config tab bar style
    class func configTabBar(tabBarController: UITabBarController, viewControllersArray: [UIViewController]) {
        let selectedColor = APP_THEME_COLOR
        let noramlColor = APP_GREY_COLCR
        let noramlTextAttributeDict = NSDictionary(objects: [noramlColor,APP_TAB_FONT!], forKeys: [NSForegroundColorAttributeName,NSFontAttributeName])
        let selectedTextAttributeDict = NSDictionary(objects: [selectedColor,APP_TAB_FONT!], forKeys: [NSForegroundColorAttributeName,NSFontAttributeName])
        UITabBar.appearance().barTintColor = UIColor.clearColor()
        UITabBarItem.appearance().setTitleTextAttributes(noramlTextAttributeDict as? [String : AnyObject], forState: UIControlState.Normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedTextAttributeDict as? [String : AnyObject], forState: UIControlState.Selected)
        UITabBarItem.appearance().titlePositionAdjustment.vertical = -4
        tabBarController.viewControllers = viewControllersArray
    }

}
