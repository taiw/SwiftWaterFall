//
//  ViewController.swift
//  TestWaterfall
//
//  Created by taiw on 16/2/29.
//  Copyright © 2016年 taiw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let SCREENBOUNDS = UIScreen.mainScreen().bounds
        
        let view=MyScrollView(frame: CGRect(x: 0,y: 0,width: SCREENBOUNDS.width,height: SCREENBOUNDS.height))
        self.view.addSubview(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

