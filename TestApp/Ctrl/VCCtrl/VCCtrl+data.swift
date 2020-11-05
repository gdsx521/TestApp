//
//  VCCtrl+data.swift
//  TestApp
//
//  Created by mac on 2020/11/5.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

//代理
@objc extension VCCtrl{
    
    func initData(){
        self.startTime()
    }
    
    //启动5秒后请求
    func postData(){
        let dateSecond = Date().timeIntervalSince1970
        guard let url = URL(string: "https://api.github.com?dateSecond=\(dateSecond)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default
        let session:URLSession = URLSession(configuration: configuration)
        let task:URLSessionDataTask = session.dataTask(with: request) {[weak self] (data, response, error) in
            guard error == nil else {
                return
            }
            do{
                guard let data = data else {
                    return
                }
                guard let responseData:NSDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary else {
                    return
                }
                guard let responseDataD = responseData as? [String : Any] else {
                    return
                }
                guard let jsonStr = self?.dictToJson(responseDataD) else {
                    return
                }
                self?.lastData = jsonStr
                DispatchQueue.main.async {
                    self?.reloadData()
                }
                
            }catch{}
        }
        task.resume()
        
    }
    
    func reloadData(){
        self.textView?.text = self.lastData ?? "上次记录为空"
    }
    
    func dictToJson(_ dic:[String : Any]) -> String?{
        let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
        let str = String(data: data!, encoding: String.Encoding.utf8)
        return str
    }
    
}
