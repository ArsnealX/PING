//
//  UserInfoAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 11/13/15.
//  Copyright © 2015 Kejukeji. All rights reserved.
//

import UIKit

class UserInfoAPIOperation: NetworkOperation {
    override init() {
        super.init()
        self.cmd = CMD_USER_INFO
    }
    
    func getUserInfo() -> UserInfoModel {
        let userTel = resultJSON?["my_tel"].stringValue
        let userName = resultJSON?["my_name"].stringValue
        let headImgUrl = resultJSON?["my_head_imgurl"].stringValue
        UserInfoModel.shared.userTel = userTel!
        UserInfoModel.shared.userName = userName!
        UserInfoModel.shared.headImgUrl = headImgUrl!
        return UserInfoModel.shared    }
}
