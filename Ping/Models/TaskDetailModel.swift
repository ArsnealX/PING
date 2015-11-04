//
//  TaskDetailModel.swift
//  Ping
//
//  Created by Joshua Xiong on 28/10/2015.
//  Copyright © 2015 Joshua Xiong. All rights reserved.
//

import UIKit

class TaskDetailModel: NSObject {
    //    "task_id":"工作任务id",
    //    "heads_img":, "头像",
    //    "user_name":"用户名称",
    //    "create_timestamp":"创建时间戳",
    //    "task_state":"工作任务状态（2:审核中，6:已通过，5:未通过）",
    //    "task_content":"工作任务内容",
    //    "is_read":"阅读状态，0未读、1已读"

    var taskID:String
    var headsImgURL:String
    var userName:String
    var createTimeStamp:String
    var taskState:String
    var taskContent:String
    var isRead:Bool
    
    init(taskID:String, headsImgURL:String, userName:String, createTimeStamp:String, taskState:String, taskContent:String, isRead:Bool) {
        self.taskID = taskID
        self.headsImgURL = headsImgURL
        self.userName = userName
        self.createTimeStamp = createTimeStamp
        self.taskState = taskState
        self.taskContent = taskContent
        self.isRead = isRead
        super.init()
    }
}
