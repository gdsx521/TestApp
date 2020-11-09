//
//  HistoryCtrl+delegate.swift
//  TestApp
//
//  Created by mac on 2020/11/5.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension HistoryCtrl:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier:"CellID")
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1,reuseIdentifier: "CellID")
        }
        cell?.backgroundColor = UIColor.white
        cell?.textLabel?.backgroundColor = UIColor.clear
        cell?.textLabel?.tintColor = UIColor.clear
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell?.textLabel?.textColor = UIColor.black
        if let dictV:NSDictionary = self.datas[indexPath.row] as? NSDictionary {
            if dictV.allKeys.count > 0 {
                cell?.textLabel?.text = (dictV.allKeys[0] as? String) ?? ""
            }
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var value = ""
        if let dictV:NSDictionary = self.datas[indexPath.row] as? NSDictionary {
            if dictV.allValues.count > 0 {
                value = (dictV.allValues[0] as? String) ?? ""
            }
        }
        let ctrl = VCCtrl()
        ctrl.lastData = value
        ctrl.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
}
