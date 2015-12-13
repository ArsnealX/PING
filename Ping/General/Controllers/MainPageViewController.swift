//
//  MainPageViewController.swift
//  Ping
//
//  Created by Joshua Xiong on 12/13/15.
//  Copyright © 2015 Kejukeji. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var viewControllersArray:Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllersArray = [MainViewController(withType: "1", index:1), MainViewController(withType: "2", index:2), MainViewController(withType: "3", index:3)]

        loadPageViewController()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        configUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = viewControllersArray.indexOf(viewController)
        if  currentIndex > 0 {
            return viewControllersArray[currentIndex! - 1]
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = viewControllersArray.indexOf(viewController)
        if  currentIndex < viewControllersArray.count - 1 {
            return viewControllersArray[currentIndex! + 1]
        }
        return nil
    }
    
    func addReview() {
        let addReviewVC = addReviewViewController()
        let reviewNav = UINavigationController(rootViewController: addReviewVC)
        PTools.configNavigationController(reviewNav, tabBarIconName: nil, needTabBar: false)
        self.presentViewController(reviewNav, animated: true, completion: nil)
    }
    
    func loadPageViewController() {
        let pageViewContainerView = UIView(frame: CGRectMake(0, 55, SCREEN_WIDTH!, SCREEN_HEIGHT! - 55))
        self.view.addSubview(pageViewContainerView)
        let pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController.delegate = self;
        pageViewController.dataSource = self;
        pageViewController.view.backgroundColor = UIColor.clearColor()
        let startViewControllers = [viewControllersArray[0]]
        self.addChildViewController(pageViewController)
        pageViewContainerView.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
        pageViewController.setViewControllers(startViewControllers, direction: .Reverse, animated: false, completion: nil)
    }
    
    func configUI() {
        self.edgesForExtendedLayout = .None
        self.automaticallyAdjustsScrollViewInsets = false
        //add write review button
        let rightItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: "addReview")
        rightItem.image = UIImage(named: "add")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
}
