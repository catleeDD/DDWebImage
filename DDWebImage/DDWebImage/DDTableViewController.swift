//
//  LXLTableViewController.swift
//  3-app小综合(swift)
//
//  Created by LIXinlei on 15/12/28.
//  Copyright © 2015年 lxl. All rights reserved.
//

import UIKit

class DDTableViewController: UITableViewController {
    
    lazy var apps = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDataSource()
        
        
    }
    
    func loadDataSource(){
        let path = NSBundle.mainBundle().pathForResource("apps.plist", ofType: nil)
        let arrM = NSArray(contentsOfFile: path!)
        arrM?.enumerateObjectsUsingBlock({ (obj, idx, stop) -> Void in
            self.apps.addObject(DDApp.app(Dict: obj as! NSDictionary))
        })
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.apps.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        }
        
        let app = self.apps[indexPath.row] as! DDApp
        cell?.textLabel?.text = app.name
        cell?.detailTextLabel?.text = app.download
        

        //一句话实现下载
        cell?.imageView?.setWebImage(urlString: app.icon!, placeholderImage: UIImage(named: "placeholder")!)
        
        return cell!
        
    }
    


}
