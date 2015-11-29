//
//  AuditTaskAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 8/24/15.
//  Copyright (c) 2015 Joshua Xiong. All rights reserved.
//

import Foundation

//"task_id"： "任务ID",
//"audit_state":"2已通过,3未通过"
class AuditTaskAPIOperation: NetworkOperation {
    private var task_Id:String
    private var audit_State:String
    
    init(withTaskId taskId:String, auditState:String) {
        task_Id = taskId
        audit_State = auditState
        super.init()
        self.cmd = CMD_AUDIT_TASK
    }
    
    override func apiParameters() -> [String: AnyObject] {

        return ["task_id":task_Id, "audit_state":audit_State]
    }
}

