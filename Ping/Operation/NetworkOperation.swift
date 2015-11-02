//
//  NetworkOperation.swift
//  Ping
//
//  Created by Joshua Xiong on 8/24/15.
//  Copyright (c) 2015 Joshua Xiong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol APICallBackDelegate: class {
    func networkOperationCompletionHandler(Operation: NetworkOperation) -> ()
    func networkOperationErrorHandler(error: ErrorType!) -> ()
}

//protocol APIDataReformer {
//    func reformDataFromResponse(originData:AnyObject) -> [String : AnyObject]
//}

class NetworkOperation : Operation {
    
    // define properties to hold everything that you'll supply when you instantiate
    // this object and will be used when the request finally starts
    //
    // in this example, I'll keep track of (a) URL; and (b) closure to call when request is done

    let URLString: String
    var cmd: String
    var timestamp: String
    var hasError: Bool
    var resultJSON: JSON?
    weak var delegate: APICallBackDelegate?


    // we'll also keep track of the resulting request operation in case we need to cancel it later
    
    weak var request: Alamofire.Request?
    
    // define init method that captures all of the properties to be used when issuing the request
    
    override init() {
        self.cmd = String()
        self.timestamp = String()
        self.URLString = SERVER_BASE_API
        self.hasError = false
        super.init()
    }
    
    // when the operation actually starts, this is the method that will be called
    
    override func main() {
        //TODO: move Notification to detail API
        var isExecuting = true
        NSNotificationCenter.defaultCenter().postNotificationName("isExecuting", object: isExecuting)
        let para = self.apiParametersWrapper()
        request = Alamofire.request(.POST, URLString, parameters: para, encoding: .JSON)
            .responseJSON { response in

                if response.result.isSuccess {
                    let JSONResultValue = JSON(response.result.value!)
                    let JSONStatusCode = JSONResultValue["state"].int
                    if JSONStatusCode == 200 {
                        self.resultJSON = JSONResultValue["result"]
                        self.hasError = false
                    }else {
                        PNErrorHandling.showWarningOfStatusCode(JSONStatusCode!)
                        self.hasError = true
                    }
                    self.delegate?.networkOperationCompletionHandler(self)

                    print("----------------Network Response For CMD:" + self.cmd + "----------------")
                    print(response.result.value)
                } else {
                    self.delegate?.networkOperationErrorHandler(response.result.error)
                    print("----------------Network Error For CMD:" + self.cmd + "----------------")
                    print(response.result.error)
                    print(response.result.debugDescription)
                }
                //Operation Completed
                self.completeOperation()
                isExecuting = false
                NSNotificationCenter.defaultCenter().postNotificationName("isExecuting", object: isExecuting)
        }
    }
    
    // we'll also support canceling the request, in case we need it
    
    override func cancel() {
        request?.cancel()
        super.cancel()
    }
    
    func apiParameters() -> [String : AnyObject] {
        //subclass override
        return ["" : ""]
    }
    
    func unwarpToken() -> String {
        if let token = APP_DEFULT_STORE.stringForKey("user_token") {
            return token
        }else {
            return "0"
        }
    }
    
    //project exclusive
    func apiParametersWrapper() -> [String : AnyObject] {
        timestamp = JXTools.timestampGenerator()
        let checkString = cmd + SERVER_PROTOCOL_STRING + timestamp
        let check = checkString.md5
        let para:[String : AnyObject] = ["check":check,
                                     "timestamp":timestamp,
                                           "cmd":cmd,
                                        "tokens":unwarpToken(),
                                          "para":apiParameters()]
        print("----------------Network Check String For CMD:" + cmd + "----------------")
        print(checkString)
        print("----------------Network Parameters For CMD:" + cmd + "----------------")
        print(para)
        return para
    }
}