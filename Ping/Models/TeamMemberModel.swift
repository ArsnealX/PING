//
//  TeamMemberModel.swift
//  Ping
//
//  Created by BeautySiteMac on 9/11/2015.
//  Copyright © 2015 Kejukeji. All rights reserved.
//

import UIKit

class TeamMemberModel: NSObject {
//    "account_id":"用户ID",
//    "user_name":"姓名",
//    "heads_img":"头像"
    var accountId:String
    var userName:String
    var headImgUrl:String
    
    init(accountId:String, userName:String, headImgUrl:String) {
        self.accountId = accountId
        self.userName = userName
        self.headImgUrl = headImgUrl
        super.init()
    }
}
