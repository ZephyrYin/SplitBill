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

class PayOptionsViewController:UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    @IBAction func cancelBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    let cellIdentifier = "paycell"
    var items:[Item] = [Item]()
    var options:[Option] = [Option]()
    var selectedRow:Int = 0
    var sB:SplitBill = SplitBill()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        for item in self.items{
            println(item.price)
        }
        sB.SetNames(items.map({$0.name}))
        sB.SetOriginalPrice(items.map({$0.price}))
        self.options = sB.Split()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue) {
//        println("option cancel")
//        dismissViewControllerAnimated(true, completion: nil)
//    }
    
//    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
//        
//        if identifier == "cancel" {
//            dismissViewControllerAnimated(true, completion: nil)
//        }
//        return true
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "details" {
            var row:Int = sender!.tag
            println(" get detail action, send \(row)")
            let destinationVC:DetailsViewController = segue.destinationViewController as! DetailsViewController
            destinationVC.option = self.options[row]
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PayCell
        var index:Int = indexPath.row
        if self.options.count == 0{
            cell.offsetText.text = "offset"
            cell.payText.text = "pay"
            cell.detailBtn.tag = index
        }else{
            cell.offsetText.text =  NSString(format: "%.2f", self.options[index].overFlow) as String
            if self.options[index].overFlow<0{
                cell.offsetText.textColor = UIColor.redColor()
            }else {
                cell.offsetText.textColor = UIColor.greenColor()
            }

            cell.payText.text = String(self.options[index].totalPay)
            cell.detailBtn.tag = index
        }
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var index:Int = indexPath.row
        self.selectedRow = index
        println("You selected cell #\(index)!")
    }
}
