//
//  VCCtrl+timer.swift
//  TestApp
//
//  Created by mac on 2020/11/5.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

//定时器
extension VCCtrl{
    
    
    //开始定时器刷新时间
    func startTime(){
        self.timer?.invalidate()
        self.timer = nil
        let tiemr = Timer.init(timeInterval: 5, target: self, selector: #selector(postData), userInfo: nil, repeats: true)
        self.timer = tiemr
        RunLoop.current.add(tiemr, forMode: RunLoop.Mode.default)
    }
    
    
    //关闭定时器
    func stopTimeUpdate(){
        self.timer?.invalidate()
        self.timer = nil
    }
    
}
