//
//  AccountIsRegAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 9/14/15.
//  Copyright © 2015 Joshua Xiong. All rights reserved.
//

import Foundation

class AccountIsRegAPIOperation: NetworkOperation {
    
    private var phoneNumber:String
    
    init(withPhoneNumber accountID:String) {
        self.phoneNumber = accountID
        super.init()
        self.cmd = CMD_CHECK_ACCOUNT_STATUS
    }
    
    override func apiParameters() -> [String : AnyObject] {
        return ["account_id" : phoneNumber]
    }
    
    func isReg() -> Bool {
        
        return (resultJSON?["ret"] == 0)
    }
}