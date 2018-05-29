//
//  ViewController.swift
//  boxue01-Demo
//
//  Created by caihongguang on 2018/5/29.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stringArray = ["1","2","3","4","5","6","7"]
        
        //过滤数组
        let fullFilter =  stringArray.flatMap { Int($0)
            }.filter{$0 % 2 == 0}
        print(fullFilter)
        
        let partialFilter = stringArray[4..<stringArray.count].flatMap{Int($0)}.filter{$0 % 2 == 0}
        print(partialFilter)
        
        
    }

  

}

//过滤数组简单，过滤用户输入就要delegate相对复杂，这时候就要切入 RxSwift
extension ViewController:UITextFieldDelegate
{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//1. Map input to Int
        if let n = Int(string) {
            //2.filter the even number
            if n % 2 == 0 {
                print("Even \(n)" )
            }
        }

        return true
        
    }
  
    
    
}



