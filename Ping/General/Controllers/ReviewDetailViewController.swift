//
//  reviewDetailViewController.swift
//  
//
//  Created by Joshua Xiong on 8/10/15.
//
//

import UIKit

class reviewDetailViewController: UIViewController {
    @IBOutlet weak var passButton: UIButton!
    @IBOutlet weak var notPassButton: UIButton!
    
    let mainQueue: NSOperationQueue = NSOperationQueue()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        let nibNameOrNil:String? = "ReviewDetailViewController"
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.configUI()
    }

    
    //MARK:DELEGATE AND DATASOURCE
    
    
    //MARK:EVENT RESPONDER
    
    
    //MARK:PRIVATE METHOD
    func configUI() {
        self.title = "某某某"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        //remove back button title
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), forBarMetrics: UIBarMetrics.Default)
        //setup button style
        buttonStyleConfig(passButton)
        buttonStyleConfig(notPassButton)
    }
    
    func buttonStyleConfig(button:UIButton) {
        button.layer.shadowColor = UIColor.lightGrayColor().CGColor
        button.layer.shadowOffset = CGSizeMake(4, 4)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 2;
    }

}
