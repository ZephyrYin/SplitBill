//
//  ViewController.swift
//  SplitBill
//
//  Created by Xinyi Yin on 6/15/15.
//  Copyright (c) 2015 Xinyi Yin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, G8TesseractDelegate {
    var sB:SplitBill = SplitBill()
    override func viewDidLoad() {
        super.viewDidLoad()
        var tesseract:G8Tesseract = G8Tesseract(language:"eng");
        tesseract.delegate = self;
        //tesseract.charWhitelist = "01234567890";
        tesseract.image = UIImage(named: "Images/receipt.jpeg");
        tesseract.recognize();
        
        NSLog("%@", tesseract.recognizedText);
        
        var test:[Float] = [3.4, 5.6, 10.1]
        sB.SetOriginalPrice(test)
        sB.SetTaxRate(0.0875)
        sB.PrintOriginalPrice()
        sB.Split()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

