//
//  PTColor.swift
//  Ping
//
//  Created by zhizhong.zhou on 16/5/5.
//  Copyright © 2016年 Kejukeji. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    
    static func colorWithRGB(red:CGFloat ,green:CGFloat,blue:CGFloat) -> (UIColor) {
        let color = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
        return color
    }
    
    static func ptBackGroundGrayColor()->(UIColor) {
        return UIColor.colorWithRGB(242.0, green: 242.0, blue: 242.0)
    }
    
}