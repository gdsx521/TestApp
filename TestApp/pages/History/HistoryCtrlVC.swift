//
//  HistoryCtrl.swift
//  TestApp
//
//  Created by mac on 2020/11/5.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

//历史记录
class HistoryCtrl: UIViewController {
    
    var table:UITableView?
    
    var vm = HistoryCtrlVM()
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    
    func configUI(){
        table = UITableView(frame: self.view.bounds, style: .plain)
        table!.rowHeight = 44
        table!.backgroundColor = UIColor.lightGray
        table!.tableFooterView = UIView()
        table!.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        self.view.addSubview(table!)
        
        //渲染每行cell
        self.vm.dataObserver.bind(to: table!.rx.items(cellIdentifier: "cellID", cellType: UITableViewCell.self)){ row,model,cell in
            cell.backgroundColor = UIColor.white
            cell.textLabel?.backgroundColor = UIColor.clear
            cell.textLabel?.tintColor = UIColor.clear
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
            cell.textLabel?.textColor = UIColor.black
            if let dictV:NSDictionary = model as? NSDictionary {
                if dictV.allKeys.count > 0 {
                    cell.textLabel?.text = (dictV.allKeys[0] as? String) ?? ""
                }
            }
            
            
        }.disposed(by: bag)
        
        //点击每行cell
        table!.rx.modelSelected([String:String].self).subscribe(onNext: { [weak self] (model) in
            var value = ""
            if let dictV:NSDictionary = model as? NSDictionary {
                if dictV.allValues.count > 0 {
                    value = (dictV.allValues[0] as? String) ?? ""
                }
            }
            let ctrl = IndexCtrlVC()
            let vmodel = IndexCtrlVM()
            vmodel.dataStr = value
            ctrl.vm = vmodel
            ctrl.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(ctrl, animated: true)
        }).disposed(by: bag)
    
        
        vm.reloadData()
        
    }
    
}

