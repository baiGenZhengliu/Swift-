//
//  ViewController.swift
//  Swift轮播
//
//  Created by HuJiazhou on 16/7/16.
//  Copyright © 2016年 HuJiazhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let views = HJZView(frame: self.view.bounds)
    
        view.addSubview(views)
        
}

}