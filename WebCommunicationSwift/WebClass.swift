//
//  WebClass.swift
//  WebCommunicationSwift
//
//  Created by Prasanna on 13/04/17.
//  Copyright © 2017 Prasanna. All rights reserved.
//

import UIKit

@objc protocol WebClassDelegate{
     func delegateCommunicationHandler(withHandlerClass handlerClass: WebClass, withDownloadDidCompleteWith serverResponce: URLResponse, withError error: Error?, withResponceObject responceObject: Any, withRelatedContext context: String)
}

class WebClass: NSObject {
    var delegate:WebClassDelegate! = nil
    
    class func isNetworkAvailable() -> Bool
    {
        let reachability: Reachability = Reachability.forInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
        
        if networkStatus == 0 {
            return false
        }
        else {
            let internetReachableFoo = Reachability(hostName: "www.apple.com")
            if (internetReachableFoo != nil) {
                return true
            }
            else {
                return false
            }
        }        
    }
    
    func request(withUrl requestUrl: String, withParameters params: AnyObject, withRequestMethod requestMethod: String, withNetWorkHandler delegate: WebClassDelegate, withRelatedContext context: String)
    {
        let urlStr = requestUrl
        let url = URL(string: urlStr)
        
        var request: URLRequest = URLRequest(url: url!)
        
        request.httpMethod = requestMethod
        
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        request.timeoutInterval = 30.0
        request.httpBody = params as? Data

        let responcenil:String? = nil

        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            
            if error != nil{
                delegate.delegateCommunicationHandler(withHandlerClass: self, withDownloadDidCompleteWith: response!, withError: error, withResponceObject: responcenil, withRelatedContext: context)
                return
            }
            do {
                let resultJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                delegate.delegateCommunicationHandler(withHandlerClass: self, withDownloadDidCompleteWith: response!, withError: error, withResponceObject: resultJson, withRelatedContext: context)
            } catch {
                
                delegate.delegateCommunicationHandler(withHandlerClass: self, withDownloadDidCompleteWith: response!, withError: error, withResponceObject: responcenil, withRelatedContext: context)
            }
        })
        task.resume()
    }
}
