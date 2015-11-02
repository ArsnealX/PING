//
//  CreateTaskAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 8/24/15.
//  Copyright (c) 2015 Joshua Xiong. All rights reserved.
//

import Foundation

class CreateTaskAPIOperation: NetworkOperation {
    override init() {
        super.init()
        self.cmd = CMD_CREATE_TASK
    }
}

