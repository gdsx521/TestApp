//
//  HistoryCtrl+data.swift
//  TestApp
//
//  Created by mac on 2020/11/5.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

extension HistoryCtrl {
    
    func initData() -> Void {
        DJSQliteTools.getAllListData { [weak self](arr) in
            guard let arr = arr,arr.count > 0 else {
                return
            }
            self?.datas = arr
            self?.table?.reloadData()
        }
    }
    
}
