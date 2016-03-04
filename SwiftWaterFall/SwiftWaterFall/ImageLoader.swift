//
//  ImageLoader.swift
//  TestWaterfall
//
//  Created by taiw on 16/2/29.
//  Copyright © 2016 taiw. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView{
    func resizeToWidth(width:CGFloat){
        if let origin_width=self.image?.size.width,origin_height=self.image?.size.height {
            let new_width=width
            let new_height=new_width*origin_height/origin_width
            
            self.frame=CGRect(x: 0, y: 0, width: new_width, height: new_height)
        }
    }    
}

class ImageLoader:NSObject {
    
    var imagesArray:NSMutableArray? // Image url name
    
    class func shared() -> ImageLoader
    {
        struct Static {
            static var loader: ImageLoader?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token, {
            Static.loader = ImageLoader()
        })
        return Static.loader!
    }
    
    func loadImage(array:NSMutableArray?){
        //relpace here
        self.imagesArray=["https://ss0.baidu.com/-fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=84a637e708d79123ffe093749d355917/0823dd54564e92589f2fe1019882d158cdbf4ec1.jpg",
                          "http://g.hiphotos.baidu.com/image/pic/item/ca1349540923dd54e8807039d309b3de9d8248f4.jpg",
                          "http://g.hiphotos.baidu.com/image/pic/item/fd039245d688d43fa9943bf77f1ed21b0ef43bf1.jpg",
                          "http://h.hiphotos.baidu.com/image/pic/item/0eb30f2442a7d933a759a435a84bd11372f00186.jpg",
                          "http://b.hiphotos.baidu.com/image/pic/item/00e93901213fb80edacf8d0f32d12f2eb83894c8.jpg",
                          "https://ss0.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=c898bddf19950a7b6a3549c43ad0625c/14ce36d3d539b600be63e95eed50352ac75cb7ae.jpg",
                          "http://c.hiphotos.baidu.com/image/pic/item/1b4c510fd9f9d72a0ad7c614d62a2834349bbb0c.jpg",
                          "https://ss0.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=d4af367956e736d147138b08ab514ffc/94cad1c8a786c917139f2a9ccb3d70cf3ac757f2.jpg",
                          "https://ss0.baidu.com/-fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=5c00db24cd95d143c576e32343f18296/03087bf40ad162d9ec74553b14dfa9ec8a13cd7a.jpg",
                          "https://ss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=7237860f952397ddc9799f046983b216/dc54564e9258d109a4d1165ad558ccbf6c814d23.jpg",
                          "http://h.hiphotos.baidu.com/image/pic/item/72f082025aafa40f7c884d31af64034f79f0198b.jpg",
                          "https://ss1.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=7f74bb149745d688bc02b5a494c37dab/f703738da97739120f92f746fd198618367ae265.jpg",
                          "http://g.hiphotos.baidu.com/image/pic/item/32fa828ba61ea8d3db04c642920a304e251f5855.jpg",
                          "http://a.hiphotos.baidu.com/image/pic/item/f11f3a292df5e0fea17be0d7586034a85fdf7280.jpg",
                          "http://a.hiphotos.baidu.com/image/pic/item/0d338744ebf81a4ce917568fd22a6059252da64b.jpg"]
    }
    
    
}