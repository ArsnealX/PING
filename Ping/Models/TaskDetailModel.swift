//
//  TaskDetailModel.swift
//  Ping
//
//  Created by Joshua Xiong on 28/10/2015.
//  Copyright © 2015 Joshua Xiong. All rights reserved.
//

import UIKit

class TaskDetailModel: NSObject {

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
