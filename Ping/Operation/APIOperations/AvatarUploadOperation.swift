//
//  AvatarUploadOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 11/30/15.
//  Copyright © 2015 Kejukeji. All rights reserved.
//

import UIKit

class AvatarUploadOperation: ImageUploadOperation {
    init(avatarImageData:NSData) {
        super.init()
        self.fileData = avatarImageData
    }
}
