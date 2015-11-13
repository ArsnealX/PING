//
//  TeamRankingModel.swift
//  Ping
//
//  Created by Joshua Xiong on 11/13/15.
//  Copyright © 2015 Kejukeji. All rights reserved.
//

import UIKit

class TeamRankingModel: NSObject {
//    "heads_img":"头像",
//    "user_name":"用户名称",
//    "year_point":"年度总分",
//    "month_point":"月度总分",
//    "week_point":"本周总分"
    var headImgUrl:String
    var userName:String
    var yearPoint:String
    var monthPoint:String
    var weekPoint:String
    
    init(headImgUrl:String, userName:String, yearPoint:String, monthPoint:String, weekPoint:String) {
        self.headImgUrl = headImgUrl
        self.userName = userName
        self.yearPoint = yearPoint
        self.monthPoint = monthPoint
        self.weekPoint = weekPoint
        super.init()
    }
}
