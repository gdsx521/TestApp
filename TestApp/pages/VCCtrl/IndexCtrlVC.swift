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

class IndexCtrlVC: UIViewController {
    
    var topLabel:UILabel?
    var textView:UITextView?
    
    var vm = IndexCtrlVM()
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.bindVM()
    }
    
    func bindVM(){
        vm.dataObserver
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self](freshData) in
                self?.textView?.text = freshData
        }).disposed(by: bag)
        vm.reloadData()
    }

    
    func configUI(){
        
        //导航栏右边按钮
        let button = UIButton.init(type: .custom)
        button.setTitle("更多历史", for: UIControl.State.normal)
        button.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        let _ = button.rx.tap.subscribe(onNext: { [weak self](flag) in
            let ctrl = HistoryCtrl()
            ctrl.hidesBottomBarWhenPushed = true
            ctrl.title = "查看更多历史记录"
            self?.navigationController?.pushViewController(ctrl, animated: true)
        }, onError: { (error) in
        }, onCompleted: {
        }) {
        }
        let rightNavItem = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = rightNavItem
        
        
        //内容视图
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
        textView?.text = ""
        textView?.textColor = UIColor.black
    }


    deinit {
        
    }
    
}

