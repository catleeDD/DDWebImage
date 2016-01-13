//
//  LXLOperation.swift
//  3-app小综合(swift)
//
//  Created by LIXinlei on 15/12/28.
//  Copyright © 2015年 lxl. All rights reserved.
//

import UIKit


//专门负责下载图片
class DDOperation: NSOperation {

    var downBlock: ((UIImage)->Void)?
    var urlString: String? //图片的icon地址
    
    //创建一个方法用来设置downBlock和urlString
//    func setUrlStringAndDownloadBlock(urlString:String, downBlock: (UIImage)->Void){
//        self.downBlock = downBlock
//        self.urlString = urlString
//    }
    //初始化方法,直接赋值
    init(fromUrlString urlString:String, downBlock:((UIImage)->Void)) {
        super.init()
        self.downBlock = downBlock
        self.urlString = urlString
    }
    
    override func main() {
        autoreleasepool { () -> () in
            assert(self.downBlock != nil, "回调不能为空!")
            assert(self.urlString != nil, "图片地址不能为空!")
            
            //查看自己是不是已经被取消
            if self.cancelled{
                return
            }
            
            var image: UIImage?
            //下载图片
            NSThread.sleepForTimeInterval(1)
            NSLog("正在下载图片...")
            
            //查看自己是不是已经被取消
            if self.cancelled{
                return
            }
            
            let url = NSURL(string: self.urlString!)
            let data = NSData(contentsOfURL: url!)
            
            //保存到沙盒中
            if let imageData = data{
                //存放路径
                let filePath = LXLSandboxTool.cachesPath(urlString: self.urlString!)
                imageData.writeToFile(filePath, atomically: true)
                image = UIImage(data: imageData)
                
            }else{
                NSLog("请检查url地址是否正确")
            }
            
            //主线程回调
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                if self.downBlock != nil{
                    self.downBlock!(image!)
                }
            }
        }
    }
    
    
    
    
    
}
