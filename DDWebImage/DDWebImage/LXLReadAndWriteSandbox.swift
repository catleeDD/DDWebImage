//
//  LXLReadAndWriteSandbox.swift
//  3-app小综合(swift)
//
//  Created by LIXinlei on 15/12/28.
//  Copyright © 2015年 lxl. All rights reserved.
//

import UIKit

class LXLSandboxTool: NSObject {


    class func cachesPath(urlString urlString:(String))->String{
        let cache = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, .UserDomainMask, true).last

        let nsCache: NSString = cache!
        let nsUrlString: NSString = urlString
        return nsCache.stringByAppendingPathComponent(nsUrlString.lastPathComponent)
    }
    
    //从文件路径获取图片
    class func imageFromSandbox(urlString urlString:(String))->UIImage?{
        let imagePath = self.cachesPath(urlString: urlString)
        
        return UIImage(contentsOfFile: imagePath)
    }
    
}
