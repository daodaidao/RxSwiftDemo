//
//  ViewController.swift
//  WhyUseRxSwift
//https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/why_rxswift.html
//  Created by caihongguang on 2018/5/28.
//  C@objc @objc @objc opyright © 2018年 SYJ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

var ntfObserver:NSObjectProtocol!

private var observerContext = 0

//为什么要使用 RxSwift?

//我们先看一下 RxSwift能够帮助我们做些什么:

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    let tag = DisposeBag()
    
   
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //传统实现方法:
       //1.点击事件
//        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 1000, height: 200)
        
        URLSession.shared.dataTask(with: URLRequest (url: URL.init(fileURLWithPath: ""))){
            (data,response,error) in
            guard error == nil else {
                
                print("data error : ....")
                return
            }
            
            guard let data = data else {
                print("Data Task Error: unknown")
                return
            }
            
            print("Data Task Success with count: \(data.count)")
            }.resume()
        
        ntfObserver = NotificationCenter.default.addObserver(forName: .UIApplicationWillEnterForeground, object: nil, queue: nil, using: { (notification) in
            print("Application Will Enter Foreground")
        })
        
        
        
        
        
        //通过 Rx来实现:
        button.rx.tap .subscribe(onNext:{
            print("button Tapped Rx")
        }) .disposed(by: tag)
        //2.代理
//      你不需要书写代理的配置代码，就能获得想要的结果
        scrollView.rx.contentOffset .subscribe(onNext: { contentOffSet in
            
            print("Rx-> contentOffSet:\(contentOffSet)")

        }).disposed(by: tag)
        
        //3.闭包回调
        URLSession.shared.rx.data(request: URLRequest(url: URL.init(fileURLWithPath: "")))
            .subscribe(onNext: { data in
                print("Data Task Success with count: \(data.count)")
            }, onError: { error in
                print("Data Task Error: \(error)")
            })
            .disposed(by: tag)
        
        //4.通知 你不需要去管理观察者的生命周期，这样你就有更多精力去关注业务逻辑。
        NotificationCenter.default.rx
            .notification(.UIApplicationWillEnterForeground)
            .subscribe(onNext: { (notification) in
                print("Rx ->Application Will Enter Foreground")
            })
            .disposed(by: tag)
        //5.KVO 和后面 6.多个任务之间有依赖关系 7.等待多个并发任务完成后处理结果/..单独写demo 演示
        
//        那么为什么要使用 RxSwift ？
//
//        复合 - Rx 就是复合的代名词
//        复用 - 因为它易复合
//        清晰 - 因为声明都是不可变更的
//        易用 - 因为它抽象的了异步编程，使我们统一了代码风格
//        稳定 - 因为 Rx 是完全通过单元测试的
    }
    
    
    @objc func buttonTapped() {
        
        print("button tapped")
        
    }
    
  
}




extension ViewController:UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("代理contentOffSet:\(scrollView.contentOffset)")
    }
   
}



