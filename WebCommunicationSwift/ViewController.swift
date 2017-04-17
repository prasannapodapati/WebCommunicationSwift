//
//  ViewController.swift
//  WebCommunicationSwift
//
//  Created by Prasanna on 13/04/17.
//  Copyright © 2017 Prasanna. All rights reserved.
//

import UIKit

class ViewController: UIViewController,WebClassDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let params:String? = nil
        if WebClass.isNetworkAvailable()
        {
            SVProgressHUD.show()
            WebClass().request(withUrl: "https://itunes.apple.com/in/rss/newapplications/limit=100/json", withParameters: params as AnyObject, withRequestMethod: "GET", withNetWorkHandler: self, withRelatedContext: "ITUNES")
        }
        else
        {
            self.showAlertView(withMessage: "Network is not Reachable, Please try again", withTitle: "QLIMO", cancelButton: "OK")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlertView(withMessage message: String, withTitle title: String, cancelButton: String) {
        let alert = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButton(withTitle: cancelButton)
        alert.show()
    }
    func delegateCommunicationHandler(withHandlerClass handlerClass: WebClass, withDownloadDidCompleteWith serverResponce: URLResponse, withError error: Error?, withResponceObject responceObject: Any, withRelatedContext context: String) {
        SVProgressHUD.dismiss()
        NSLog("\(responceObject)")
    }

}

