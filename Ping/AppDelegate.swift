//
//  AppDelegate.swift
//  BPSV
//
//  Created by Joshua Xiong on 6/12/15.
//  Copyright (c) 2015 itinnox. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    enum ShortcutType: String {
        case addNewReview
        
        init?(fullType: String) {
            guard let last = fullType.componentsSeparatedByString(".").last else { return nil }
            
            self.init(rawValue: last)
        }
        
        var type: String {
            return NSBundle.mainBundle().bundleIdentifier! + ".\(self.rawValue)"
        }
    }
    
    static let applicationShortcutUserInfoIconKey = "applicationShortcutUserInfoIconKey"
        
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        configUI()
        //set up fabric
        Fabric.with([Crashlytics.self()])
        //start network status monitor
        SSASwiftReachability.sharedManager?.startMonitoring()
        
        var launchedFromShortCut = false
        //check for shortcutitem
        if #available(iOS 9.0, *) {
            if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
                launchedFromShortCut = true
                handleShortCutItem(shortcutItem)
            }
        } else {
            // Fallback on earlier versions
        }
        
        return !launchedFromShortCut
    }
    
    @available(iOS 9.0, *)
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        completionHandler(handledShortCutItem)
    }
    
    @available(iOS 9.0, *)
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        guard ShortcutType(fullType: shortcutItem.type) != nil else { return false }
        
        guard let shortCutType = shortcutItem.type as String? else { return false }
        
        
        switch shortCutType {
            case ShortcutType.addNewReview.type :
                if APP_DEFULT_STORE.objectForKey("userInfo") != nil {
                    //Get root navigation viewcontroller and its first controller
                    let rootTabBarViewController = window!.rootViewController as? UITabBarController
                    let rootViewController = rootTabBarViewController?.viewControllers?.first as! UINavigationController
                    //Pop to root view controller so that approperiete segue can be performed
                    rootViewController.popToRootViewControllerAnimated(false)
                    rootTabBarViewController?.selectedIndex = 0

                    //present add review vc
                    let addReviewVC = addReviewViewController()
                    let reviewNav = UINavigationController(rootViewController: addReviewVC)
                    PTools.configNavigationController(reviewNav, tabBarIconName: nil, needTabBar: false)
                    rootViewController.presentViewController(reviewNav, animated: true, completion: nil)
                }
                handled = true
            default:
                break
        }
        return handled
    }
    
    func configUI() {
        UIFont.fontNamesForFamilyName("NotoSansHans")
        let mainVC = MainViewController()
        let teamVC = TeamViewController()
        let userVC  = UserViewController()
        let mainNavigationController = UINavigationController(rootViewController: mainVC)
        let teamNavigationController = UINavigationController(rootViewController: teamVC)
        let userNavigationController = UINavigationController(rootViewController: userVC)
        PTools.configNavigationController(mainNavigationController, tabBarIconName: "work", needTabBar: true)
        PTools.configNavigationController(teamNavigationController, tabBarIconName: "team", needTabBar: true)
        PTools.configNavigationController(userNavigationController, tabBarIconName: "user", needTabBar: true)
        mainVC.title = "工作"
        teamVC.title = "团队"
        userVC.title = "我"
        
        //config tabBar
        let tabBarController = UITabBarController()
        let viewControllersArray = [mainNavigationController, teamNavigationController, userNavigationController]
        PTools.configTabBar(tabBarController, viewControllersArray: viewControllersArray)
        
        //config Window
        let screenFrame = UIScreen.mainScreen().bounds
        window = UIWindow(frame: screenFrame)
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        
        //set root view controller
        let lRVC = LoginAndRegisterViewController(tabBarController: tabBarController)
        
        if APP_DEFULT_STORE.objectForKey("user_token") == nil {
            window?.rootViewController = lRVC
        }else {
            window?.rootViewController = tabBarController
        }
    }

}

