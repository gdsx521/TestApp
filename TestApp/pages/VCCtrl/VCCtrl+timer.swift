//
//  VCCtrl+timer.swift
//  TestApp
//
//  Created by mac on 2020/11/5.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


//定时器
extension VCCtrl{
    
    
    //开始定时器刷新时间
    func startTime(){
        let _  = Observable<Int>.interval(RxTimeInterval.seconds(5), scheduler: MainScheduler()).subscribe(onNext: { (state) in
            self.postData()
        }, onError: { (error) in
            
        }, onCompleted: {
            
        }, onDisposed: {
            
        })
    }
    
}
