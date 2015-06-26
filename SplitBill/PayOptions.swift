//
//  PayOptions.swift
//  SplitBill
//
//  Created by Xinyi Yin on 6/25/15.
//  Copyright (c) 2015 Xinyi Yin. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class PayOptions:UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    let cellIdentifier = "paycell"
    var content:[String] = ["one", "two", "three"]

    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PayCell
//        if self.items.count == 0{
//            cell.nameText.text = "name"
//            cell.priceText.text = "price"
//        }else{
//            cell.nameText.text = self.items[indexPath.row].name
//            cell.priceText.text = NSString(format: "%.2f", self.items[indexPath.row].price) as String
//        }
        var index:Int = indexPath.row
        cell.nameText.text = content[index]
        cell.offsetText.text = content[index]
        cell.payText.text = content[index]
        return cell
    }
}
