//
//  ImageUploadOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 11/29/15.
//  Copyright © 2015 Kejukeji. All rights reserved.
//

import UIKit
import Alamofire

class ImageUploadOperation: Operation {
    var fileData:NSData
    private let URLString:String
    
    override init() {
        URLString = SERVER_IMAGE_BASE_API
        fileData = NSData()
        super.init()
    }
    
    override func main() {
        print(URLString + self.unwarpToken())
        Alamofire.upload(.POST, URLString + self.unwarpToken(), data: fileData)
//            .progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
//                print(totalBytesWritten)
//                
//                // This closure is NOT called on the main queue for performance
//                // reasons. To update your ui, dispatch to the main queue.
//                dispatch_async(dispatch_get_main_queue()) {
//                    print("Total bytes written on main queue: \(totalBytesWritten)")
//                }
//            }
            .responseJSON { response in
                debugPrint(response)
        }
    }
        
    func unwarpToken() -> String {
        if let token = APP_DEFULT_STORE.stringForKey(kUserToken) {
            return token
        }else {
            return "0"
        }
    }
}
