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
    
    override func apiParameters() -> [String : AnyObject] {
        return ["get_key" : "all"]
    }
    
    func getUserInfo() -> UserInfoModel {
        let userTel = resultJSON?["my_tel"].stringValue
        let userName = resultJSON?["account_name"].stringValue
        let headImgUrl = resultJSON?["header_img"].stringValue
        UserInfoModel.shared.userTel = userTel!
        UserInfoModel.shared.userName = userName!
        UserInfoModel.shared.headImgUrl = headImgUrl!
        return UserInfoModel.shared    }
}
