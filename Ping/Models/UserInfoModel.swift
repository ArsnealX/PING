//
//  UserInfoModel.swift
//  Ping
//
//  Created by Joshua Xiong on 11/13/15.
//  Copyright © 2015 Kejukeji. All rights reserved.
//

import UIKit

class UserInfoModel: NSObject {
//    "my_tel":"手机号",
//    "my_name":"我的名称",
//    "my_head_imgurl":"http://www.img.com/1"
    var userTel:String
    var userName:String
    var headImgUrl:String
    
    init(userTel:String, userName:String, headImgUrl:String) {
        self.userTel = userTel
        self.userName = userName
        self.headImgUrl = headImgUrl
        super.init()
    }
}
