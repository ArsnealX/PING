//
//  TaskDetailAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 8/24/15.
//  Copyright (c) 2015 Joshua Xiong. All rights reserved.
//

import Foundation

class TaskDetailAPIOperation: NetworkOperation {
    private var task_Id:String
    
    init(withTaskId taskId:String) {
        task_Id = taskId
        super.init()
        self.cmd = CMD_FETCH_TASK_DETAIL
    }
    
    override func apiParameters() -> [String: AnyObject] {
        guard let teamId = APP_DEFULT_STORE.stringForKey(kTeamId) else {
            return ["":""]
        }
        return ["team_id":teamId, "task_id":task_Id]
    }
    
    func getMoreInfo() -> TaskMoreInfoModel {
        let taskState = resultJSON!["task_state"].stringValue
        let headsImgUrl = resultJSON!["heads_image"].stringValue
        let userName = resultJSON!["user_name"].stringValue
        let createTimeStamp = resultJSON!["create_timestamp"].stringValue
        let taskContent = resultJSON!["task_content"].stringValue
        let userAuditName = resultJSON!["user_audit_name"].stringValue
        let taskCopyTo = resultJSON!["task_copy_to"].arrayValue.map { (jsonString) -> String in
            return jsonString.stringValue
        }
        let userAttr = resultJSON!["user_attr"].stringValue
        let workState = resultJSON!["work_state"].stringValue
        let workInnovate = resultJSON!["work_innovate"].stringValue
        return TaskMoreInfoModel(taskState: taskState, headsImgUrl: headsImgUrl, userName: userName, createTimeStamp: createTimeStamp, taskContent: taskContent, userAuditName: userAuditName, taskCopyTo: taskCopyTo, userAttr: userAttr, workState: workState, workInnovate: workInnovate)
    }
}