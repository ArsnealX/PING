//
//  MyPointAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 8/24/15.
//  Copyright (c) 2015 Joshua Xiong. All rights reserved.
//

import Foundation

class MyPointAPIOperation: NetworkOperation {
    enum pointAction:String {
        case year = "year"
        case month = "month"
        case week = "week"
    }
    
    private var action:pointAction
    init(action:pointAction) {
        self.action = action
        super.init()
        self.cmd = CMD_FETCH_MY_POINT
    }
    
    override func apiParameters() -> [String : AnyObject] {
        return ["action" : action.rawValue]
    }
    
    func getUserPoint() -> String {
        return (resultJSON?["point"].stringValue)!
    }
}