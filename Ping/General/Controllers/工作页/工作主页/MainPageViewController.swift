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
    var currentButtonIndex = 0
    let pageVC = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)

    
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
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else {
            return
        }
        let oldSwitchButton = self.view.viewWithTag(currentButtonIndex + 100) as! UIButton
        oldSwitchButton.selected = false
        currentButtonIndex = viewControllersArray.indexOf((pageViewController.viewControllers?.last)!)!
        let newSwitchButton = self.view.viewWithTag(currentButtonIndex + 100) as! UIButton
        newSwitchButton.selected = true
        print(currentButtonIndex)
    }
    
    func addReview() {
        let addReviewVC = addReviewViewController()
         self.navigationController!.pushViewController(addReviewVC, animated: true)
    }
    
    func loadPageViewController() {
        loadSwitchView()
        let pageViewContainerView = UIView(frame: CGRectMake(0, 40, SCREEN_WIDTH!, SCREEN_HEIGHT! - 40))
        self.view.addSubview(pageViewContainerView)
        pageVC.delegate = self
        pageVC.dataSource = self
        pageVC.view.backgroundColor = UIColor.clearColor()
        let startViewControllers = [viewControllersArray[0]]
        self.addChildViewController(pageVC)
        pageViewContainerView.addSubview(pageVC.view)
        pageVC.didMoveToParentViewController(self)
        pageVC.setViewControllers(startViewControllers, direction: .Reverse, animated: false, completion: nil)
    }
    
    func switchButton(sender:UIButton) {
        let oldSwitchButton = self.view.viewWithTag(currentButtonIndex + 100) as! UIButton
        oldSwitchButton.selected = false
        sender.selected = true;
        currentButtonIndex = sender.tag - 100;
        let startViewControllers = [viewControllersArray[currentButtonIndex]]
        pageVC.setViewControllers(startViewControllers, direction: .Reverse , animated: false, completion: nil)
    }
     func goPlanClick() -> Void {
        let planViewController = PTPlanViewController()
        self.presentViewController(planViewController, animated: true) { 
            
        }
        
    }
    func loadSwitchView() {
        self.addLeftButtonWithIcon(UIImage(named: "history"), actionClick: #selector(MainPageViewController.goPlanClick))
        let createdButton = UIButton(frame: CGRectMake(0 ,0 , 50 , 30))
        let reviewButton = UIButton(frame: CGRectMake(0 ,0 , 50 , 30))
        let ccButton = UIButton(frame: CGRectMake(0 ,0 , 50 , 30))
        let fontSize:CGFloat = 14
        createdButton.setTitle("执办", forState: .Normal)
        createdButton.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        createdButton.setTitleColor(UIColor(red:0.59, green:0.59, blue:0.59, alpha:1), forState: .Normal)
        createdButton.setTitleColor(UIColor.whiteColor(), forState: .Selected)
        createdButton.setBackgroundImage(JXTools.getImageWithColor(APP_THEME_COLOR, size: CGSizeMake(50, 20)), forState: .Selected)
        createdButton.setBackgroundImage(JXTools.getImageWithColor(UIColor.clearColor(), size: CGSizeMake(50, 20)), forState: .Normal)
        createdButton.center = CGPointMake(SCREEN_WIDTH! * 0.15, 20)
        createdButton.tag = 100;
        createdButton.layer.cornerRadius = 6
        createdButton.layer.masksToBounds = true
        createdButton.addTarget(self, action: #selector(MainPageViewController.switchButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        reviewButton.setTitle("审核", forState: .Normal)
        reviewButton.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        reviewButton.setTitleColor(UIColor(red:0.59, green:0.59, blue:0.59, alpha:1), forState: .Normal)
        reviewButton.setTitleColor(UIColor.whiteColor(), forState: .Selected)
        reviewButton.titleLabel?.textColor = UIColor.whiteColor()
        reviewButton.setBackgroundImage(JXTools.getImageWithColor(APP_THEME_COLOR, size: CGSizeMake(50, 20)), forState: .Selected)
        reviewButton.setBackgroundImage(JXTools.getImageWithColor(UIColor.clearColor(), size: CGSizeMake(50, 20)), forState: .Normal)
        reviewButton.center = CGPointMake(SCREEN_WIDTH! / 2, 20)
        reviewButton.tag = 101
        reviewButton.layer.cornerRadius = 6
        reviewButton.layer.masksToBounds = true
        reviewButton.addTarget(self, action: #selector(MainPageViewController.switchButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        ccButton.setTitle("@我", forState: .Normal)
        ccButton.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        ccButton.setTitleColor(UIColor(red:0.59, green:0.59, blue:0.59, alpha:1), forState: .Normal)
        ccButton.setTitleColor(UIColor.whiteColor(), forState: .Selected)
        ccButton.titleLabel?.textColor = UIColor.whiteColor()
        ccButton.setBackgroundImage(JXTools.getImageWithColor(APP_THEME_COLOR, size: CGSizeMake(50, 20)), forState: .Selected)
        ccButton.setBackgroundImage(JXTools.getImageWithColor(UIColor.clearColor(), size: CGSizeMake(50, 20)), forState: .Normal)
        ccButton.center = CGPointMake(SCREEN_WIDTH! * 0.85, 20)
        ccButton.tag = 102;
        ccButton.layer.cornerRadius = 6
        ccButton.layer.masksToBounds = true
        ccButton.addTarget(self, action: #selector(MainPageViewController.switchButton(_:)) , forControlEvents: UIControlEvents.TouchUpInside)
        let containerView = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH!, 40))
        containerView.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1)
        containerView.addSubview(createdButton)
        containerView.addSubview(reviewButton)
        containerView.addSubview(ccButton)
        
        createdButton.selected = true
        currentButtonIndex = 0
        
        self.view.addSubview(containerView)
    }
    
    func configUI() {
        self.navigationItem.title = "PING"
        self.edgesForExtendedLayout = .None
        self.automaticallyAdjustsScrollViewInsets = false
        //add write review button
        let rightItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MainPageViewController.addReview))
        rightItem.image = UIImage(named: "add")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.rightBarButtonItem = rightItem
        self.view.backgroundColor = APP_GREY_COLCR
    }
    
}
