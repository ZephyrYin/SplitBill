//
//  ViewController.swift
//  SplitBill
//
//  Created by Xinyi Yin on 6/15/15.
//  Copyright (c) 2015 Xinyi Yin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, G8TesseractDelegate {
    var sB:SplitBill = SplitBill()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let captureSession = AVCaptureSession()
//        captureSession.sessionPreset = AVCaptureSessionPresetLow
//        let devices = AVCaptureDevice.devices()
//        println(devices)
        
        
        
        
//        var test:[Float] = [3.4, 5.6, 10.1]
//        sB.SetOriginalPrice(test)
//        sB.SetTaxRate(0.0875)
//        sB.PrintOriginalPrice()
//        sB.Split()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

