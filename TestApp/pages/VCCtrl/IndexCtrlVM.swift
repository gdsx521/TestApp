//
//  VCCtrlVM.swift
//  TestApp
//
//  Created by mac on 2020/11/9.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class IndexCtrlVM:BaseViewModel {
        
    
    var dataStr:String? //固定值,不使用定时器
    let dataObserver = BehaviorRelay<String>(value: "") //使用定时器,每隔5秒获取新值
    
    
    func reloadData(){
        
        if let dataStr = self.dataStr,dataStr.count > 0  {
            self.dataObserver.accept(dataStr)
            return
        }
        
        DJSQliteTools.getAllListData { [weak self](arr) in
            guard let datas = arr,datas.count > 0 else{
                return
            }
            if let dictV = datas[0] as? NSDictionary {
                if dictV.allKeys.count > 0 {
                    let resData = (dictV.allValues[0] as? String) ?? ""
                    self?.dataObserver.accept(resData)
                }
            }
        }
        
        
        let _  = Observable<Int>.interval(RxTimeInterval.milliseconds(5000), scheduler: MainScheduler.instance).subscribe(onNext: { (state) in
            self.postData()
        }, onError: { (error) in
            
        }, onCompleted: {
            
        }, onDisposed: {
            
        })
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
                guard let resData = self?.dictToJson(responseDataD) else {
                    return
                }
                DJSQliteTools.saveData(resData)
                self?.dataObserver.accept(resData)
                
            }catch{}
        }
        task.resume()
        
    }

    func dictToJson(_ dic:[String : Any]) -> String?{
        let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
        let str = String(data: data!, encoding: String.Encoding.utf8)
        return str
    }
    
}
