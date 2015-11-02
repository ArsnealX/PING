//
//  JXNAPIBaseManager.swift
//  
//
//  Created by Joshua Xiong on 8/14/15.
//
//

import UIKit
import ReachabilitySwift

protocol JXNAPIManagerApiCallBackDelegate {
    func managerCallAPIDidSuccess(manager:JXNAPIBaseManager)
    func managerCallAPIDidFailed(manager:JXNAPIBaseManager)
}

protocol JXNAPIManagerCallbackDataReformer {
    func reformDataFromManager(originData:NSDictionary, manager:JXNAPIBaseManager) -> NSDictionary
}

protocol JXNAPIManagerParamSourceDelegate {
    func paramsForApiManager(manager:JXNAPIBaseManager) -> NSDictionary
}

class JXNAPIBaseManager: NSObject {
    var delegate:JXNAPIManagerApiCallBackDelegate!
    var paramSource:JXNAPIManagerParamSourceDelegate!
    var fetchedRawData:AnyObject!
    //check network reachability
    class func checkNetworkStatus() {
        println("Checking Reachability")
        var reachability:Reachability = Reachability(hostname:"www.baidu.com")
        var result:String
        Reachability.NetworkStatus.ReachableViaWWAN
        var reachabilityStatus = reachability.currentReachabilityStatus
        println("Reachability Status：\(reachabilityStatus)")
        switch reachabilityStatus {
        case .NotReachable:
            result = "Not Reachable"
        case .ReachableViaWiFi:
            result = "WIFI Working"
        case .ReachableViaWWAN:
            result = "Cellular Working"
        default:
            result = "Unknown"
        }
        println(result)
    }
    
    func fetchDataWithReformer(reformer:JXNAPIManagerCallbackDataReformer?) -> AnyObject {
        var resultData:AnyObject!
        if let unwrappedReformer = reformer {
            resultData = reformer?.reformDataFromManager(fetchedRawData as! NSDictionary, manager: self)
        }else {
            resultData = fetchedRawData
        }
        return resultData
    }
    
//    func loadData
    
}
