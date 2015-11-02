//
//  appMarco.swift
//  Ping
//
//  Created by Joshua Xiong on 8/7/15.
//  Copyright (c) 2015 Joshua Xiong. All rights reserved.
//

import Foundation
import UIKit

let NAVIGATIONBAR_HEIGHT:CGFloat = 44.0
let STATUSBAR_HEIGHT:CGFloat = 22.0
let SCREEN_HEIGHT = UIApplication.sharedApplication().keyWindow?.bounds.size.height
let SCREEN_WIDTH = UIApplication.sharedApplication().keyWindow?.bounds.size.width
let APP_FONT_NAME = "NotoSansHans-Medium"
let APP_NAV_FONT = UIFont(name: APP_FONT_NAME, size: 18)
let APP_TAB_FONT = UIFont(name: APP_FONT_NAME, size: 10)
let APP_THEME_COLOR = UIColor(red:0, green:0.69, blue:0.45, alpha:1)
let APP_ALERT_COLOR = UIColor(red:0.91, green:0, blue:0.16, alpha:1)
let APP_PASS_COLOR = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1)
let APP_BLUE_COLOR = UIColor(red:0.2, green:0.53, blue:0.89, alpha:1)
let APP_GREY_COLCR = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)
let APP_DEFULT_STORE = NSUserDefaults.standardUserDefaults()