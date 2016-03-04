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
        self.imagesArray=["https://ss0.baidu.com/-fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=84a637e708d79123ffe093749d355917/0823dd54564e92589f2fe1019882d158cdbf4ec1.jpg","https://ss0.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=d3f9111f791ed21b66c929e59d6fddae/b151f8198618367a8ed9ff302a738bd4b21ce58f.jpg","https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=64175659840a19d8d403830503fb82c9/e7cd7b899e510fb3a78c787fdd33c895d0430c44.jpg","https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=4da4ff1895ef76c6cfd2fc2bad16fdf6/f9dcd100baa1cd11daf25f19bc12c8fcc3ce2d46.jpg","https://ss0.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=c898bddf19950a7b6a3549c43ad0625c/14ce36d3d539b600be63e95eed50352ac75cb7ae.jpg","https://ss0.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=d4af367956e736d147138b08ab514ffc/94cad1c8a786c917139f2a9ccb3d70cf3ac757f2.jpg","https://ss0.baidu.com/-fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=5c00db24cd95d143c576e32343f18296/03087bf40ad162d9ec74553b14dfa9ec8a13cd7a.jpg","https://ss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=7237860f952397ddc9799f046983b216/dc54564e9258d109a4d1165ad558ccbf6c814d23.jpg","https://ss1.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=7f74bb149745d688bc02b5a494c37dab/f703738da97739120f92f746fd198618367ae265.jpg"]
    }
    
    
}