//
//  CreateTaskAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 8/24/15.
//  Copyright (c) 2015 Joshua Xiong. All rights reserved.
//

import Foundation

class CreateTaskAPIOperation: NetworkOperation {
//    "user_audit_id"： "审核人ID",
//    "task_copy_to":[{"copy_to_id":"抄送人id"}],
//    "task_content":"工作任务内容",
//    "work_state":"工作状态评价",
//    "work_innovate":"工作创新评价"
    private var userAuditId:String
    private var taskCopyTo:Array<[String : String]>
    private var taskContent:String
    private var workState:String
    private var workInnovate:String
    
    init(userAuditId:String, taskCopyTo:Array<String>, taskContent:String, workState:String, workInnovate:String) {
        self.userAuditId = userAuditId
//        self.taskCopyTo = taskCopyTo
        self.taskCopyTo = taskCopyTo.map({ (IDString) -> [String : String] in
            return ["copy_to_id":IDString]
        })
        self.taskContent = taskContent
        self.workState = workState
        self.workInnovate = workInnovate
        super.init()
        self.cmd = CMD_CREATE_TASK
    }
    
    override func apiParameters() -> [String: AnyObject] {
        return ["user_audit_id":userAuditId, "task_copy_to":taskCopyTo, "task_content":taskContent, "work_state":workState, "work_innovate":workInnovate]
    }
}

