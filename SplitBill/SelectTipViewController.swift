//
//  SelectTip.swift
//  SplitBill
//
//  Created by Xinyi Yin on 6/25/15.
//  Copyright (c) 2015 Xinyi Yin. All rights reserved.
//

import Foundation
import UIKit

class SelectTipViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet var setBtn: UIButton!
    
    @IBAction func scanBtn(sender: AnyObject) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.cameraCaptureMode = .Photo
            picker.delegate = self
            presentViewController(picker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
    
    @IBOutlet var tipText: UILabel!
    @IBOutlet var tipSlider: UISlider!
    @IBOutlet var sliderValeLabel: UILabel!
    var dValue:DefaultValue = DefaultValue()
    var tipRatio:Float = 0.15
    var billImg:UIImage = UIImage()
    let picker = UIImagePickerController()
    
    
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
            dValue.SetDefaultTip(self.tipRatio)
            let destinationVC:DraftBillViewController = segue.destinationViewController as! DraftBillViewController
            destinationVC.tipRatio = self.tipRatio
            destinationVC.billImg = self.billImg
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        self.billImg = chosenImage //4
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    func noImg(){
        let alertVC = UIAlertController(title: "No Image", message: "Please scan bill first", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
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