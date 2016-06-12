//
//  QueryTeamMemberAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 8/24/15.
//  Copyright (c) 2015 Joshua Xiong. All rights reserved.
//

import Foundation

class QueryTeamMemberAPIOperation: NetworkOperation {
    override init() {
        super.init()
        self.cmd = CMD_QUERY_TEAM_MEMBER
    }
    
    func getTeamMemberList() -> Array<TeamMemberModel> {
        let teamMemberListArray = resultJSON?.arrayValue.map{singleMemberJSON -> TeamMemberModel in
            let accountId = singleMemberJSON["account_id"].stringValue
            let userName = singleMemberJSON["account_name"].stringValue
            let headImgUrl = singleMemberJSON["header_img"].stringValue
            return TeamMemberModel(accountId: accountId, userName: userName, headImgUrl: headImgUrl)
        }
        
        return teamMemberListArray!
    }
}