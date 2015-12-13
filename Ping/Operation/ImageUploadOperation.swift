//
//  ImageUploadOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 11/29/15.
//  Copyright © 2015 Kejukeji. All rights reserved.
//

import UIKit
import Alamofire
protocol ImageUploadCallBackDelegate: class {
    func imageUploadOperationCompletionHandler() -> ()
    func imageUploadOperationErrorHandler() -> ()
}

class ImageUploadOperation: Operation {
    var fileData:NSData
    private let URLString:String

    weak var delegate: ImageUploadCallBackDelegate?

    override init() {
        URLString = SERVER_IMAGE_BASE_API
        fileData = NSData()
        super.init()
    }
    
    override func main() {
        print(URLString + self.unwarpToken())
        Alamofire.upload(
            .POST,
            URLString + self.unwarpToken() + "?v=\(JXTools.timestampGenerator())",
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(data: self.fileData, name: "imageData")
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    self.delegate?.imageUploadOperationCompletionHandler()
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                    self.delegate?.imageUploadOperationErrorHandler()
                }
            }
        )
    }
        
    func unwarpToken() -> String {
        if let token = APP_DEFULT_STORE.stringForKey(kUserToken) {
            return token
        }else {
            return "0"
        }
    }
}
