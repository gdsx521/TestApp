//
//  ViewController.swift
//  TestApp
//
//  Created by mac on 2020/11/5.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class VCCtrl: UIViewController {
    let bag = DisposeBag()
    
    var topLabel:UILabel?
    var lastData:String? //上次请求的记录
    var textView:UITextView?    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.initData()
    }
    
    func configUI(){
        
        //导航栏右边按钮
        let rightNavItem = UIBarButtonItem.init(title: "更多历史", style: UIBarButtonItem.Style.done, target: self, action: #selector(rightNavItemClick))
        self.navigationItem.rightBarButtonItem = rightNavItem
        
        let viewWidth = self.view.bounds.size.width
        let viewHeight = self.view.bounds.size.height
        let outViewWidth = viewWidth - 12 * 2
        let outViewHeight = viewHeight - 10 * 2
        
        let outV:UIView = UIView.init(frame: CGRect.init(x: 12, y: 10, width:outViewWidth, height: outViewHeight))
        self.view.addSubview(outV)
        topLabel = UILabel.init(frame: CGRect.init(x: 0, y: 60, width: outViewWidth, height: 50))
        self.view.addSubview(topLabel!)
        topLabel?.text = "以下是上次数据请求记录每隔5秒会更新一次数据:"
        topLabel?.numberOfLines = 2;
        topLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        topLabel?.textColor = UIColor.black
        outV.addSubview(topLabel!)
        
        let originY = topLabel!.frame.maxY + 30
        let scrollHeight = outViewHeight - originY
        textView = UITextView.init(frame: CGRect.init(x: 0, y: originY, width: outViewWidth, height: scrollHeight))
        outV.addSubview(textView!)
        textView?.isEditable = false
        textView?.font = UIFont.systemFont(ofSize: 15)
        textView?.text = self.lastData ?? "上次记录为空"
        textView?.textColor = UIColor.black
        
    }
    
    @objc func rightNavItemClick(){
        let ctrl = HistoryCtrl()
        ctrl.hidesBottomBarWhenPushed = true
        ctrl.title = "查看更多历史记录"
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    deinit {
        
    }
    
}

