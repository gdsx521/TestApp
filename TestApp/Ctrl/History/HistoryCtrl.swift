//
//  HistoryCtrl.swift
//  TestApp
//
//  Created by mac on 2020/11/5.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

//历史记录
class HistoryCtrl: UIViewController {
    
    var table:UITableView?
    var datas:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    func configUI(){
        table = UITableView(frame: self.view.bounds, style: .plain)
        table!.delegate = self
        table!.dataSource = self
        table!.tableFooterView = UIView()
        self.view.addSubview(table!)
    }
    
}

