//
//  MyScrollView.swift
//  TestWaterfall
//
//  Created by taiw on 16/3/2.
//  Copyright © 2016 taiw. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

let PAGE_SIZE=15 //Image nums
let SPACING_WID:CGFloat=2
let SPACING_HEIGHT:CGFloat=3

class MyScrollView:UIScrollView ,UIScrollViewDelegate,UIGestureRecognizerDelegate {
    var loadedImageDic:NSMutableDictionary=NSMutableDictionary()
    var loadedImageArray:NSMutableArray=NSMutableArray()
    var photoArray:NSMutableArray=NSMutableArray()
    var imgTagDic:NSMutableDictionary=NSMutableDictionary()
    
    var leftColumnHeight:CGFloat=3.0
    var midColumnHeight:CGFloat=3.0
    var rightColumnHeight:CGFloat=3.0
    
    var imgTag:Int=10000 //
    var page:Int=1
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.delegate=self
        self.backgroundColor=UIColor.darkGrayColor()//BG Color
        self.pagingEnabled=false
        self.showsHorizontalScrollIndicator=false
        self.showsVerticalScrollIndicator=false
        
        self.initWithPhotoBox()
    }
    
    //Three columns
    func initWithPhotoBox(){
        let wid=frame.size.width/3
        let leftView=UIView(frame: CGRect(x: 0,y: 0,width: wid,height: frame.size.height))
        let midView=UIView(frame: CGRect(x: leftView.frame.origin.x+wid,y: 0,width: wid,height: frame.size.height))
        let rightView=UIView(frame: CGRect(x: midView.frame.origin.x+wid,y: 0,width: wid,height: frame.size.height))
        leftView.tag=100
        midView.tag=101
        rightView.tag=102
        leftView.backgroundColor=UIColor.clearColor()
        midView.backgroundColor=UIColor.clearColor()
        rightView.backgroundColor=UIColor.clearColor()
        self.addSubview(leftView)
        self.addSubview(midView)
        self.addSubview(rightView)
        
        //Image Lists
        ImageLoader.shared().loadImage(nil)
        
        //1st loading
        for i in 0..<PAGE_SIZE {
            if let imageName=ImageLoader.shared().imagesArray!.objectAtIndex(i) as? String{
                
                self.imageStartDownloading(imageName)
            }
        }
        self.page=1
    }
    
    func imageStartDownloading(imageName:String){
        //Using Kingfisher
        if let cache=ImageCache.defaultCache.retrieveImageInMemoryCacheForKey(imageName){
            let imgView=UIImageView(image: cache)
            imgView.resizeToWidth(frame.size.width/3-SPACING_WID)
            
            self.addImage(imgView, name: imageName)
            self.adjustContentSize(false)
        }
        else {
            let imgView=UIImageView()
            if let url=NSURL(string: imageName){
                imgView.kf_setImageWithURL(url,placeholderImage: nil,
                                           optionsInfo: nil,
                                           progressBlock: nil,
                                           completionHandler: {(image, error, cacheType,imageURL) -> () in
                                            imgView.resizeToWidth(self.frame.size.width/3-SPACING_WID)
                                            
                                            self.addImage(imgView, name: imageName)
                                            self.adjustContentSize(false)
                })
            }
        }
    }
    
    func adjustContentSize(isEnd:Bool){
        if let leftView=viewWithTag(100),midView=viewWithTag(101),rightView=viewWithTag(102) {
            if leftColumnHeight>=midColumnHeight && leftColumnHeight >= rightColumnHeight {
                self.contentSize=leftView.frame.size
            }
            else{
                if midColumnHeight>=rightColumnHeight {
                    self.contentSize=midView.frame.size
                }else {
                    self.contentSize=rightView.frame.size
                }
            }
        }
    }
    
    //Decide which col to add
    func getTheShortColumn()->CGFloat{
        if leftColumnHeight<=midColumnHeight && leftColumnHeight <= rightColumnHeight {
            return leftColumnHeight
        }
        else{
            if midColumnHeight<=rightColumnHeight {
                return midColumnHeight
            }else {
                return rightColumnHeight
            }
        }
    }
    
    func addImage(imageView:UIImageView,name:String) {
        if loadedImageDic.objectForKey(name) != nil {
            return
        }
        loadedImageDic.setObject(imageView, forKey: name)
        loadedImageArray.addObject(imageView)
        photoArray.addObject(name)
        
        imageTagWithAction(imageView,name:name)
        
        let width:CGFloat=imageView.frame.size.width
        let height:CGFloat=imageView.frame.size.height
        //Which col is lowest
        if leftColumnHeight<=midColumnHeight && leftColumnHeight<=rightColumnHeight {
            let leftView=self.viewWithTag(100)! as UIView
            leftView.addSubview(imageView)
            
            imageView.frame=CGRect(x: 2, y: leftColumnHeight, width: width, height: height)
            leftColumnHeight=leftColumnHeight+height+SPACING_HEIGHT
            leftView.frame=CGRect(x: 0, y: 0, width: frame.size.width/3, height: leftColumnHeight)
            
        } else {
            if midColumnHeight<=rightColumnHeight  {
                let midView=self.viewWithTag(101)! as UIView
                midView.addSubview(imageView)
                
                imageView.frame=CGRect(x: 2, y: midColumnHeight, width: width, height: height)
                midColumnHeight=midColumnHeight+height+SPACING_HEIGHT
                midView.frame=CGRect(x: frame.size.width/3, y: 0, width: frame.size.width/3, height: midColumnHeight)
            } else {
                let rightView=self.viewWithTag(102)! as UIView
                rightView.addSubview(imageView)
                
                imageView.frame=CGRect(x: 2, y: rightColumnHeight, width: width, height: height)
                rightColumnHeight=rightColumnHeight+height+SPACING_HEIGHT
                rightView.frame=CGRect(x: 2*frame.size.width/3, y: 0, width: frame.size.width/3, height: rightColumnHeight)
            }
        }
    }
    
    func checkImageIsVisible(){
        for i in 0..<loadedImageArray.count {
            if let imgView=loadedImageArray.objectAtIndex(i) as? UIImageView {
                if (self.contentOffset.y-imgView.frame.origin.y)>imgView.frame.size.height || imgView.frame.origin.y>(self.frame.size.height+self.contentOffset.y){
                    imgView.image=nil//
                }else{
                    if let imageName=self.imgTagDic.objectForKey(imgView.tag.description) as? String{
                        let imgView=UIImageView()
                        if let url=NSURL(string: imageName){
                            imgView.kf_setImageWithURL(url,placeholderImage: nil,
                                                       optionsInfo: nil,
                                                       progressBlock: nil,
                                                       completionHandler: {(image, error, cacheType,imageURL) -> () in
                                                        //print("Downloaded & resized \(imageURL!)!")
                                                        imgView.resizeToWidth(self.frame.size.width/3-SPACING_WID)
                                                        
                            })
                        }
                    }
                }
            }
        }
    }
    
    func imageTagWithAction(view:UIImageView,name:String){
        view.tag=self.imgTag
        self.imgTagDic.setObject(name, forKey: view.tag.description)
        self.imgTag++
        let tapRecognizer=UITapGestureRecognizer(target: self,action: #selector(imageClickWithTag))
        
        tapRecognizer.delegate=self
        view.userInteractionEnabled=true
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (self.contentOffset.y+self.frame.size.height-self.getTheShortColumn())>30 {
            pullRefreshImages()
        }
    }
    
    func pullRefreshImages(){
        let index=self.page*PAGE_SIZE
        let imgNum=ImageLoader.shared().imagesArray!.count
        if index>=imgNum {
            self.adjustContentSize(true)
        }else {
            if (imgNum-self.page*PAGE_SIZE)>PAGE_SIZE {
                for i in index..<PAGE_SIZE{
                    if let imageName=ImageLoader.shared().imagesArray?.objectAtIndex(i) as? String {
                        imageStartDownloading(imageName)
                    }
                }
            }else{
                for i in index..<imgNum{
                    if let imageName=ImageLoader.shared().imagesArray?.objectAtIndex(i) as? String {
                        imageStartDownloading(imageName)
                    }
                }
            }
            page++
        }
    }
    
    //Image click handler
    func imageClickWithTag(sender:UITapGestureRecognizer){
        if let view=sender.view as? UIImageView{
            if let imageName=self.imgTagDic.objectForKey(view.tag.description) {
                
                print("DoWithPhoto:\(imageName)")
            }
            
        }
    }
    
}

