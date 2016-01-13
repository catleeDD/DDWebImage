//
//  LXLApp.swift
//  3-app小综合(swift)
//
//  Created by LIXinlei on 15/12/28.
//  Copyright © 2015年 lxl. All rights reserved.
//

import UIKit

class DDApp: NSObject {

    var name: String?
    var icon: String?
    var download: String?
    
    class func app(Dict dict:NSDictionary)->AnyObject{
        let app = DDApp()
        app.name = dict["name"] as? String
        app.icon = dict["icon"] as? String
        app.download = dict["download"] as? String
        return app
    }

    
}
