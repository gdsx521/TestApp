//
//  HistoryCtrlVM.swift
//  TestApp
//
//  Created by mac on 2020/11/9.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HistoryCtrlVM:BaseViewModel {
    
    let dataObserver = BehaviorRelay<NSArray>(value: [])
    
    func reloadData(){
        DJSQliteTools.getAllListData { [weak self](arr) in
            guard let resData = arr,resData.count > 0 else {
                return
            }
            self?.dataObserver.accept(resData as NSArray)
        }
    }
}


