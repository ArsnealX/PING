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
}