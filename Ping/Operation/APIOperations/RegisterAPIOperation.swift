//
//  RegisterAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 9/14/15.
//  Copyright © 2015 Joshua Xiong. All rights reserved.
//

import Foundation

class RegisterAPIOperation: NetworkOperation {
    private var phoneString:String
    private var passwordMD5String:String
    
    init(withPhoneNumber accountID:String, password:String) {
        self.phoneString = accountID
        self.passwordMD5String = password.md5
        super.init()
        self.cmd = CMD_USER_REGISTER
    }
    
    override func apiParameters() -> [String : AnyObject] {
        return ["account_id" : phoneString, "password" : passwordMD5String]
    }
    
    func getToken() -> String {
        return resultJSON!["tokens"].stringValue
    }
}
