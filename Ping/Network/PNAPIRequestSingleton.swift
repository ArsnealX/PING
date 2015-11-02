//
//  PNAPIRequestSingleton.swift
//  Ping
//
//  Created by Joshua Xiong on 8/17/15.
//  Copyright (c) 2015 Kejukeji. All rights reserved.
//

import Foundation
import Alamofire

class PNAPIRequestSingleton {
    class func requestCallBackTest(callback:(String)->Void) {
        let testString = "API Request Callback Test"
        callback(testString)
    }
}