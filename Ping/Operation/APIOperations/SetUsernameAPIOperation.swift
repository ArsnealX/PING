//
//  SetUsernameAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 8/24/15.
//  Copyright (c) 2015 Joshua Xiong. All rights reserved.
//

import Foundation

class SetUsernameAPIOperation: NetworkOperation {
    private var userName:String
    init(withUserName username:String) {
        self.userName = username
        super.init()
        self.cmd = CMD_SET_USERNAME
    }
    
    override func apiParameters() -> [String : AnyObject] {
        return ["set_key":0,"set_value" : userName]
    }
}