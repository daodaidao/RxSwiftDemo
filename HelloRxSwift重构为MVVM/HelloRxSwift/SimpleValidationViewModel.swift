//
//  SimpleValidationViewModel.swift
//  HelloRxSwift
//
//  Created by caihongguang on 2018/5/29.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

//ViewModel 将用户输入行为，转换成输出的状态
class SimpleValidationViewModel {
    
    //输出
    let usernameValid: Observable<Bool>
    let passwordValid: Observable<Bool>
    let everythingValid: Observable<Bool>
    
    // 输入 -> 输出
    init(
        username: Observable<String>,
        password: Observable<String>
        ) {
      
        usernameValid = username
            .map { $0.characters.count >= minimalUsernameLength }
            .share(replay: 1)
        
        passwordValid = password
            .map { $0.characters.count >= minimalPasswordLength }
            .share(replay: 1)
        
        everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        
        
        
        
    }
    
    
    
    
    
    
}
