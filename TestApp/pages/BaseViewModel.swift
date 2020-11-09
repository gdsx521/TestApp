//
//  BaseViewModel.swift
//  TestApp
//
//  Created by mac on 2020/11/9.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel: ViewModelLifeCycle {
    var bag = DisposeBag()
    
    // MARK: - ViewModelLifeCycle
    func viewLoaded() { }
    func viewAppearing() { }
    func viewAppeared() { }
    func viewDisappearing() { }
    func viewDisappeared() { }
    func viewDestroy() { }
}


protocol ViewModelLifeCycle {
    func viewLoaded()
    func viewAppearing()
    func viewAppeared()
    func viewDisappearing()
    func viewDisappeared()
    func viewDestroy()
}
