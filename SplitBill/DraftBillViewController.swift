//
//  DraftBill.swift
//  SplitBill
//
//  Created by Xinyi Yin on 6/25/15.
//  Copyright (c) 2015 Xinyi Yin. All rights reserved.
//

import Foundation
import UIKit

class DraftBillViewController:UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    @IBAction func cancelBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    var sC:ScanBill = ScanBill()
    var billImg:UIImage = UIImage(named: "Images/food3.png")!
    var items:[Item] = [Item]()
    let cellIdentifier = "draftcell"
    var tipRatio:Float = Float()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        println("get tip is \(self.tipRatio)")
        items = sC.getPriceFromImg(billImg)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "split" {
            println(" get split action \(self.items.count)")
            let destinationVC:PayOptionsViewController = segue.destinationViewController as! PayOptionsViewController
            destinationVC.items = self.items
        }
    }
    
//    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
//        
//        if identifier == "cancel" {
//            println("nimade")
//            dismissViewControllerAnimated(true, completion: nil)
//        }
//        return true
//    }
    
//    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue) {
//        println("cancel")
//        dismissViewControllerAnimated(true, completion: nil)
//    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DraftCell
        if self.items.count == 0{
            cell.nameText.text = "name"
            cell.priceText.text = "price"
        }else{
            cell.nameText.text = self.items[indexPath.row].name
            cell.priceText.text = NSString(format: "%.2f", self.items[indexPath.row].price) as String
        }
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            println("delete \(indexPath.row)")
            self.items.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
}
