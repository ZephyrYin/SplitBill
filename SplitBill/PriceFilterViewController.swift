//
//  PriceFilterViewController.swift
//  SplitBill
//
//  Created by Xinyi Yin on 7/1/15.
//  Copyright (c) 2015 Xinyi Yin. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PriceFilterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBAction func cancelBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func saveBtn(sender: AnyObject) {
        if self.maxRow <= self.minRow{
            let alertController = UIAlertController(title: "Value Error", message:
                "minPrice is bigger than maxPrice", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }else{
            defaultValue.SetMinFilterPrice(pickerDataSource[self.minRow])
            defaultValue.SetMaxFilterPrice(pickerDataSource[self.maxRow])
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBOutlet var minimumPricePicker: UIPickerView!
    @IBOutlet var maximumPricePicker: UIPickerView!
    var defaultValue: DefaultValue = DefaultValue()
    
    var pickerDataSource:[Int] = [Int]()
    
    var minRow:Int = Int()
    var maxRow:Int = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerDataSource += 0...100
        minRow = defaultValue.GetMinFilterPrice()
        maxRow = defaultValue.GetMaxFilterPrice()
        
        self.minimumPricePicker.dataSource = self;
        self.minimumPricePicker.delegate = self;
        
        self.maximumPricePicker.dataSource = self;
        self.maximumPricePicker.delegate = self;
        
        self.minimumPricePicker.selectRow(minRow, inComponent: 0, animated: true)
        self.maximumPricePicker.selectRow(maxRow, inComponent: 0, animated: true)
        
         self.minimumPricePicker.tag = 0
         self.maximumPricePicker.tag = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{

        if(pickerView == minimumPricePicker){
            return String(self.pickerDataSource[row])
        }
        
        if(pickerView == maximumPricePicker){
            return String(self.pickerDataSource[row])
        }

        return ""
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == minimumPricePicker){
            self.minRow = row
            println(self.minRow)
        }
        
        if(pickerView == maximumPricePicker){
            self.maxRow = row
            println(self.maxRow)
        }
    }
    
    
}
