//
//  DetailsViewController.swift
//  SplitBill
//
//  Created by Xinyi Yin on 6/28/15.
//  Copyright (c) 2015 Xinyi Yin. All rights reserved.
//

import Foundation

import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    @IBAction func cancelBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveBtn(sender: AnyObject) {
        screenShot()
        dismissViewControllerAnimated(true, completion: nil)
    }
    var option:Option = Option(names: [String](), originalPrices:[Float](), payMoney:[Int]())
    let cellIdentifier:String = "detailcell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.option.names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DetailCell
        let index = indexPath.row
        if self.option.names.count == 0{
            cell.nameText.text = "name"
            cell.overflowText.text = "overflow"
            cell.payText.text = "price"
        }else{
            cell.nameText.text = self.option.names[index]
            var overflow:Float = Float(self.option.payMoney[index]) - self.option.originalPrices[index]
            cell.overflowText.text = NSString(format: "%.2f", overflow) as String
            if overflow<0{
                cell.overflowText.textColor = UIColor.redColor()
            }else {
                cell.overflowText.textColor = UIColor.greenColor()
            }
            cell.payText.text = String(self.option.payMoney[index])
        }
        return cell
    }

    func screenShot() {
        //Create the UIImage
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.renderInContext(UIGraphicsGetCurrentContext())
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Save it to the camera roll
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}