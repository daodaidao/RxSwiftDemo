//
//  ViewController.swift
//  HelloRxSwift
//
//  Created by caihongguang on 2018/5/28.
//  Copyright © 2018年 SYJ. All rights reserved.
//https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/first_app.html

import UIKit
import RxSwift
import RxCocoa

fileprivate let minimalUsernameLength = 5
fileprivate let minimalPasswordLength = 5

class ViewController: UIViewController {
    
    
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidOutlet: UILabel!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!
    
    @IBOutlet weak var doSomethingOutlet: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //我的第一个 RxSwift应用程序 -输入验证
        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        //swift自动为闭包提供参数名缩写功能 https://www.jianshu.com/p/49c1e060c99c
        let usernameVaild = usernameOutlet.rx.text.orEmpty.map { $0.count >= minimalUsernameLength
            }.share(replay: 1)
        
        let passwordVaild = passwordOutlet.rx.text.orEmpty.map {
            $0.count >= minimalPasswordLength
            }.share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameVaild,passwordVaild){$0 && $1}.share(replay: 1)
        
        usernameVaild
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameVaild.bind(to: usernameValidOutlet.rx.isHidden).disposed(by: disposeBag)
        
        passwordVaild
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid.bind(to: doSomethingOutlet.rx.isEnabled).disposed(by: disposeBag)
        
        doSomethingOutlet.rx.tap
            .subscribe({ [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
        
        
    }
    
    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alertView.show()
    }
    
    
}

/*
 share(replay: 1) 是用来做什么的？
 
 我们用 usernameValid 来控制用户名提示语是否隐藏以及密码输入框是否可用。shareReplay 就是让他们共享这一个源，而不是为他们单独创建新的源。这样可以减少不必要的开支。
 
 disposed(by: disposeBag) 是用来做什么的？
 
 和我们所熟悉的对象一样，每一个绑定也是有生命周期的。并且这个绑定是可以被清除的。disposed(by: disposeBag)就是将绑定的生命周期交给 disposeBag 来管理。当 disposeBag 被释放的时候，那么里面尚未清除的绑定也就被清除了。这就相当于是在用 ARC 来管理绑定的生命周期。 这个内容会在 Disposable 章节详细介绍。
 */

