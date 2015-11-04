//
//  TaskMoreInfoModel.swift
//  Ping
//
//  Created by Joshua Xiong on 4/11/2015.
//  Copyright © 2015 Joshua Xiong. All rights reserved.
//

import UIKit

class TaskMoreInfoModel: NSObject {
    //    "task_state":"工作任务状态(审核中,审核失败,未通过,通过)"
    //    "heads_img":"头像",
    //    "user_name":"用户名称",
    //    "create_timestamp":"创建时间戳",
    //    "task_content":"工作任务内容",
    //    "user_audit_name":"审核人姓名",
    //    "task_copy_to":[{"name":"抄送人姓名数组"}],
    //    "user_attr":"用户属性，1:创建人、2:审核人、3:抄送人",
    //    "work_state":"工作状态评价",
    //    "work_innovate":"工作创新评价"
    
    var taskState:String
    var headsImgUrl:String
    var userName:String
    var createTimeStamp:String
    var taskContent:String
    var userAuditName:String
    var taskCopyTo:Array<String>
    var userAttr:String
    var workState:String
    var workInnovate:String
    
    init(taskState:String, headsImgUrl:String, userName:String, createTimeStamp:String, taskContent:String, userAuditName:String, taskCopyTo:Array<String>, userAttr:String, workState:String, workInnovate:String) {
        self.taskState = taskState
        self.headsImgUrl = headsImgUrl
        self.userName = userName
        self.createTimeStamp = createTimeStamp
        self.taskContent = taskContent
        self.userAuditName = userAuditName
        self.taskCopyTo = taskCopyTo
        self.userAttr = userAttr
        self.workState = workState
        self.workInnovate = workInnovate
        super.init()
    }
}
