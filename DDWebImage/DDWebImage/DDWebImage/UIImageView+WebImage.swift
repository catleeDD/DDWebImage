//
//  UIImageView+WebImage.swift
//  3-app小综合(swift)
//
//  Created by LIXinlei on 15/12/28.
//  Copyright © 2015年 lxl. All rights reserved.
//

import Foundation
import UIKit

private var urlStringKey = "urlStringKey"
extension UIImageView{
    
    //为扩展类动态添加属性,绑定一个urlString
    var urlString: String? {
        set{
            //这里一定要是newValue,相当于set传过来的值
            objc_setAssociatedObject(self, &urlStringKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get{
            return objc_getAssociatedObject(self, &urlStringKey) as? String
        }
        
    }
    
    
    func setWebImage(urlString urlString: String, placeholderImage: UIImage){
        //用管理类下载图片,实例化管理类对象
        let manager = DDWebImageManager.sharedManager
        
        //1.内存缓存
        if let image = manager.images.objectForKey(urlString){
            NSLog("从内存缓存中取出图片")
            self.image = (image as! UIImage)
            return
        }
        
        
        
        //2.沙盒
        if let image = LXLSandboxTool.imageFromSandbox(urlString: urlString) {
            NSLog("从沙盒中取图片")
            self.image = image
            manager.images.setObject(image, forKey: urlString)
            return
        }
        
        
        
        
        //3.下载,需要判断下载操作是否匹配
        
        self.image = placeholderImage
        
        if self.urlString != nil && self.urlString != urlString{
            NSLog("取消了原来的下载!")
            manager.cancelOperation(urlString: self.urlString!)
            self.downloadImage(urlString)
            return
        }
        
        if self.urlString == nil{ //第一次进来
            self.downloadImage(urlString)
            return
        }
        //如果不相等,取消原来的操作
        
        
        
        
//        NSLog("正在下载...")
        
        
    }
    
    //下载图片方法
    func downloadImage(urlString:String){
        DDWebImageManager.sharedManager.downLoadWebImage(urlString: urlString) { (image) -> Void in
            self.image = image
            NSLog("图片下载完毕,")
        }
        
        //一开始下载就给imageView绑定一个urlString,用于滚动之后判断是不是与当前传入的urlString相匹配,如果不匹配,就取消以前的下载操作,开始新的下载操作
        self.urlString = urlString
    }
    
    
    
}




