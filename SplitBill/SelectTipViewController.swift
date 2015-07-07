//
//  SelectTip.swift
//  SplitBill
//
//  Created by Xinyi Yin on 6/25/15.
//  Copyright (c) 2015 Xinyi Yin. All rights reserved.
//

import Foundation
import UIKit

class SelectTipViewController: UIViewController{
    
    @IBOutlet var setBtn: UIButton!
    
    @IBOutlet var tipText: UILabel!
    @IBOutlet var tipSlider: UISlider!
    @IBOutlet var sliderValeLabel: UILabel!
    var dValue:Default = Default()
    var tipRatio:Float = 0.15
    override func viewDidLoad(){
        super.viewDidLoad()
        tipRatio = dValue.GetDefaultTip()
        self.tipText.text = "\(Int(tipRatio*100))%"
        self.tipSlider.value = tipRatio*100
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderValueChanged(sender: UISlider){
        var value:Int = Int(sender.value)
        self.tipRatio = Float(value)/100
        self.sliderValeLabel.text = "\(value)%"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "settip" {
            println(" get set action \(self.tipRatio)")
            dValue.SetDefaultTip(self.tipRatio)
            let destinationVC:DraftBillViewController = segue.destinationViewController as! DraftBillViewController
            destinationVC.tipRatio = self.tipRatio
        }
    }
    
    
//    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
//        if identifier == "set" {
//            println("tttttt")
//            
//            // Create a new variable to store the instance of PlayerTableViewController
//            let destinationVC = segue.destinationViewController as DraftBill
//            destinationVC.programVar = self.tipRatio
//        }
//        return true
//    }
}