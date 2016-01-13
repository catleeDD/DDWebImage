//
//  LXLWebImageManager.swift
//  3-app小综合(swift)
//
//  Created by LIXinlei on 15/12/28.
//  Copyright © 2015年 lxl. All rights reserved.
//

import UIKit


//管理类,负责下载图片,然后把图片传给UIImageView的分类(传递需要用block)
//难点:block嵌套,管理类在操作类中的block中调用imageView分类的block,这样形成了一个调用串
class DDWebImageManager: NSObject {
    
    //懒加载
    lazy var images = NSMutableDictionary()
    lazy var operations = NSMutableDictionary()
    
    lazy var queue:NSOperationQueue = {
        let q = NSOperationQueue()
        q.maxConcurrentOperationCount = 6
        return q
    }()
    
    

    //单例
//    class var sharedManager:LXLWebImageManager{
//        struct Static {
//            static var onceToken: dispatch_once_t = 0
//            static var instance: LXLWebImageManager? = nil
//        }
//        dispatch_once(&Static.onceToken) { () -> Void in
//            Static.instance = LXLWebImageManager()
//        }
//        return Static.instance!
//    }
    //单例其他写法
//    static let instance = LXLWebImageManager()
//    class func sharedManager() -> LXLWebImageManager{
//        return instance
//    }
    class var sharedManager: DDWebImageManager{
        struct Static {
            static let instance = DDWebImageManager()
        }
        return Static.instance
    }

    
    
    //添加内存警告通知
    private override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receviMomeryWarning", name: UIApplicationDidReceiveMemoryWarningNotification, object: nil)
    }
    
    //下载图片接口+回调
    func downLoadWebImage(urlString urlString:String, complition:((UIImage)->Void)){
        //如果操作存在
        if self.operations[urlString] != nil {
            NSLog("操作已经存在")
            return
        }
        //创建操作,并赋值
        let op = DDOperation(fromUrlString: urlString) { (image) -> Void in
            //调用分类的回调,显示图片
            complition(image)
            //缓存
            self.images.setObject(image, forKey: urlString)
            self.operations.removeObjectForKey(urlString)
        }
        
        self.operations.setObject(op, forKey: urlString)
        self.queue.addOperation(op)
        
    }
    
    //取消操作的接口
    func cancelOperation(urlString urlString:String){
        //取消操作
        if let op = self.operations[urlString]{
            op.cancel()
        }
        //这样不会真正取消操作,只是一个标记,需要在下载操作中取消自己
        
        //将操作移除,否则不会再次下载
        self.operations.removeObjectForKey(urlString)
    }
    
    //内存警告
    func receviMomeryWarning(){
    
        self.queue.cancelAllOperations()
        self.images.removeAllObjects()
        self.operations.removeAllObjects()
    }
    
    
}
