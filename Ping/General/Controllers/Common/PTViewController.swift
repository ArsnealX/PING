//
//  PTViewController.swift
//  Ping
//
//  Created by zhizhong.zhou on 16/5/5.
//  Copyright © 2016年 Kejukeji. All rights reserved.
//

import UIKit

class PTViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self .addLeftReturnButton()
        self.view.backgroundColor = UIColor.ptBackGroundGrayColor()
    }
    
    override func awakeFromNib() {
        self.addLeftReturnButton()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
