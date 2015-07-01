//
//  TaxRateViewController.swift
//  SplitBill
//
//  Created by Xinyi Yin on 7/1/15.
//  Copyright (c) 2015 Xinyi Yin. All rights reserved.
//

import UIKit
import AVFoundation

class TaxRateViewController: UIViewController, G8TesseractDelegate {
    @IBAction func cancelBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveBtn(sender: AnyObject) {
        if self.taxText.text == ""{
            let alertController = UIAlertController(title: "Value Error", message:
                "Please input tax rate correctly", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }else{
            defaultValue.SetTaxRate((self.taxText.text as NSString).floatValue)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    @IBOutlet var taxText: UITextField!
    var defaultValue:Default = Default()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.taxText.text = NSString(format: "%.5f", defaultValue.GetTaxRate()) as String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}