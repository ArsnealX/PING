//
//  GetTeamNameAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 1/16/16.
//  Copyright © 2016 Kejukeji. All rights reserved.
//

import UIKit

class GetTeamNameAPIOperation: NetworkOperation {
    override init() {
        super.init()
        self.cmd = CMD_GET_TEAM_NAME
    }
    
    func getTeamName() -> String {
        return resultJSON!["team_name"].stringValue
    }

}
