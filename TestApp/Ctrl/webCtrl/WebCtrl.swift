//
//  ViewController.swift
//  TestApp
//
//  Created by mac on 2020/11/5.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ZipArchiveSDK

import JavaScriptCore
import WebKit

class WebCtrl: UIViewController {
    
    var webView:WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    func configUI(){
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0);
        
        let documentPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentPath = documentPaths[0]
        let dataSavePath = documentPath + "/HTMLPages/"
        try? FileManager.default.createDirectory(atPath: dataSavePath, withIntermediateDirectories: true, attributes: nil)
        
        let htmlPath = dataSavePath + "/index.html"
        if FileManager.default.fileExists(atPath: htmlPath) == false {
            guard let zipPackagePath = Bundle.main.path(forResource: "html", ofType: "zip") else {
                return
            }
            //解压
            SSZipArchive.unzipFile(atPath: zipPackagePath, toDestination: dataSavePath)
        }
        
        
        
        webView = WKWebView.init(frame: self.view.bounds)
        self.view.addSubview(webView!)
        self.automaticallyAdjustsScrollViewInsets = false
        if #available(iOS 13.0, *) {
            self.webView?.scrollView.contentInsetAdjustmentBehavior = .never
        }
        self.webView?.backgroundColor = UIColor.lightGray
        
//        let loadUrl = dataSavePath + "index.html#/adsetting/index"
        let loadUrl = dataSavePath + "index.html"
        let url = URL.init(fileURLWithPath: loadUrl)
        let readAccessToURL = (loadUrl as NSString).deletingLastPathComponent
        self.webView?.loadFileURL(url, allowingReadAccessTo: URL.init(fileURLWithPath: readAccessToURL))
    }
    
    
}

