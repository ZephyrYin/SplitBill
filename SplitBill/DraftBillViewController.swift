//
//  DraftBill.swift
//  SplitBill
//
//  Created by Xinyi Yin on 6/25/15.
//  Copyright (c) 2015 Xinyi Yin. All rights reserved.
//

import Foundation
import UIKit

class DraftBillViewController:UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    
    @IBOutlet var tableView: UITableView!
    @IBAction func cancelBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    var sC:ScanBill = ScanBill()
    var billImg:UIImage = UIImage()
    var items:[Item] = [Item]()
    let cellIdentifier = "draftcell"
    var tipRatio:Float = Float()
    var mycells = [DraftCell]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.items = sC.getPriceFromImg(billImg)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "split" {
//            for cell in self.mycells{
//                self.items[cell.priceText.tag].price = (cell.priceText.text as NSString).floatValue
//            }
            
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
        var index:Int = indexPath.row
        if self.items.count == 0{
            cell.nameText.text = "name"
            cell.priceText.text = "price"
        }else{
            cell.nameText.text = self.items[index].name
            cell.priceText.text = NSString(format: "%.2f", self.items[index].price) as String
        }
        cell.priceText.delegate = self
        cell.priceText.tag = index
        self.mycells.append(cell)
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            println("delete \(indexPath.row)")
            self.items.removeAtIndex(indexPath.row)
            self.mycells.removeAtIndex(indexPath.row)
//            for(var i:Int = indexPath.row+1;i<self.mycells.count;i++){
//                self.mycells[i].priceText.tag--
//            }
            self.tableView.reloadData()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        println("TextField should begin editing method called")
        return true;
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {    //delegate method
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        println("TextField should clear method called")
        return true;
    }

    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {  //delegate method
        textField.resignFirstResponder()
        self.items[textField.tag].price = (textField.text as NSString).floatValue
        println("edit \(textField.tag) to \((textField.text as NSString).floatValue)")
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        println("TextField did end editing method called")
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        self.items[textField.tag].price = (textField.text as NSString).floatValue
        println(self.items[textField.tag].price)
        println("edit \(textField.tag) to \((textField.text as NSString).floatValue)")
        return true
    }


}
