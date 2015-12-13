//
//  TaskListAPIOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 8/24/15.
//  Copyright (c) 2015 Joshua Xiong. All rights reserved.
//

import Foundation

class TaskListAPIOperation: NetworkOperation {
    private var task_role_state:String
    private var task_start_index:String
    private var task_end_index:String
    
    init(withTaskRoleState taskRoleState:String, startIndex:String, endIndex: String) {
        task_role_state = taskRoleState
        task_start_index = startIndex
        task_end_index = endIndex
        super.init()
        self.cmd = CMD_FETCH_TASK_LIST
    }
    
    override func apiParameters() -> [String : AnyObject] {
        return ["task_role_state" : task_role_state, "task_start_index" : task_start_index, "task_end_index" : task_end_index]
    }
        
    func getListArray() -> Array<TaskDetailModel> {
        let taskArray = resultJSON?.arrayValue.map{ singleTaskJSON -> TaskDetailModel in
            let taskID = singleTaskJSON["task_id"].stringValue
            let headsImg = singleTaskJSON["heads_img"].stringValue
            let userName = singleTaskJSON["user_name"].stringValue
            let createTimeStamp = singleTaskJSON["create_timestamp"].stringValue
            let taskState = singleTaskJSON["task_state"].stringValue
            let taskContent = singleTaskJSON["task_content"].stringValue
            let isReadString = singleTaskJSON["is_read"].stringValue
            var isRead:Bool = true
            if isReadString == "0" {
                isRead = false
            }
            return TaskDetailModel(taskID: taskID, headsImgURL: headsImg, userName: userName, createTimeStamp: createTimeStamp, taskState: taskState, taskContent: taskContent, isRead: isRead)
        }
        return taskArray!
    }
}