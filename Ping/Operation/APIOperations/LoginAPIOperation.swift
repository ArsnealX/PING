//
//  LoginAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 8/24/15.
//  Copyright (c) 2015 Joshua Xiong. All rights reserved.
//

import Foundation

class LoginAPIOperation: NetworkOperation {
    private var phoneString:String
    private var passwordMD5String:String
    
    init(withPhoneNumber accountID:String, password:String) {
        self.phoneString = accountID
        self.passwordMD5String = password.md5
        super.init()
        self.cmd = CMD_USER_LOGIN
    }
    
    override func apiParameters() -> [String : AnyObject] {
        return ["account_id" : phoneString, "password" : passwordMD5String]
    }
    
    func getToken() -> String {
        return resultJSON!["tokens"].stringValue
    }
    
}