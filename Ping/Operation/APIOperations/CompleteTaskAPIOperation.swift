//
//  CompleteTaskAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 8/24/15.
//  Copyright (c) 2015 Joshua Xiong. All rights reserved.
//

import Foundation

class CompleteTaskAPIOperation: NetworkOperation {
    override init() {
        super.init()
        self.cmd = CMD_COMPLETE_TASK
    }
}