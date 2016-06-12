//
//  SetReadStateAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 8/24/15.
//  Copyright (c) 2015 Joshua Xiong. All rights reserved.
//

import Foundation

class SetReadStateAPIOperation: NetworkOperation {
    private var taskId:String
     init(withTaskId taskId:String) {
        self.taskId = taskId
        super.init()
        self.cmd = CMD_SET_READ_STATUS
    }
    
    override func apiParameters() -> [String : AnyObject] {
        return ["set_key":1, "set_value":taskId]
    }
}