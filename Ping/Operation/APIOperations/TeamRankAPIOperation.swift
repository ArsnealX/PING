//
//  TeamRankAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 8/24/15.
//  Copyright (c) 2015 Joshua Xiong. All rights reserved.
//

import Foundation

class TeamRankAPIOperation: NetworkOperation {
    override init() {
        super.init()
        self.cmd = CMD_FETCH_TEAM_RANK
    }
    
    func getTemaRank() -> Array<TeamRankingModel> {
        let teamRankingArray = resultJSON?.arrayValue.map{singleRank -> TeamRankingModel in
            let headImgUrl = singleRank["header_img"].stringValue
            let userName = singleRank["account_name"].stringValue
            let yearPoint = singleRank["year_point"].stringValue
            let monthPoint = singleRank["month_point"].stringValue
            let weekPoint = singleRank["week_point"].stringValue
            return TeamRankingModel(headImgUrl: headImgUrl, userName: userName, yearPoint: yearPoint, monthPoint: monthPoint, weekPoint: weekPoint)
        }
        return teamRankingArray!
    }
}
