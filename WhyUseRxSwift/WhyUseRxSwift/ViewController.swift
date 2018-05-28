//
//  ViewController.swift
//  WhyUseRxSwift
//
//  Created by caihongguang on 2018/5/28.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
//为什么要使用 RxSwift?
//我们先看一下 RxSwift能够帮助我们做些什么:

class ViewController: UIViewController {
    
    let tag = DisposeBag()
    
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //传统实现方法:
       
//        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        //通过 Rx来实现:
        button.rx.tap .subscribe(onNext:{
            print("button Tapped Rx")
        }) .disposed(by: tag)
        
    }
    
    
    @objc func buttonTapped() {
        
        print("button tapped")
        
    }
    
}



