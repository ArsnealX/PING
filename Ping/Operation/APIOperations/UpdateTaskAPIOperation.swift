//
//  UpdateTaskAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 8/24/15.
//  Copyright (c) 2015 Joshua Xiong. All rights reserved.
//

import Foundation

class UpdateTaskAPIOperation: NetworkOperation {
    override init() {
        super.init()
        self.cmd = CMD_UPDATE_TASK
    }
}