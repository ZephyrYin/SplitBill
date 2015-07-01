//
//  Default.swift
//  SplitBill
//
//  Created by Xinyi Yin on 7/1/15.
//  Copyright (c) 2015 Xinyi Yin. All rights reserved.
//

import Foundation

class Default:NSObject{
    var maxFilterPrice:Int
    var minFilterPrice:Int
    var taxRate:Float
    
    override init(){
        self.maxFilterPrice = 20
        self.minFilterPrice = 5
        self.taxRate = 0.0875
    }
    
    func GetMinFilterPrice() -> Int{
        if NSUserDefaults.standardUserDefaults().valueForKey("minFilterPrice") != nil{
            var price = NSUserDefaults.standardUserDefaults().valueForKey("minFilterPrice") as! Int
            return price
        }else{
            NSUserDefaults.standardUserDefaults().setObject(self.minFilterPrice, forKey: "minFilterPrice")
            return self.minFilterPrice
        }
    }
    
    func SetMinFilterPrice(price: Int){
        NSUserDefaults.standardUserDefaults().setObject(price, forKey: "minFilterPrice")
        NSUserDefaults.standardUserDefaults().synchronize()
    }


    
    func GetMaxFilterPrice() -> Int{
        if NSUserDefaults.standardUserDefaults().valueForKey("maxFilterPrice") != nil{
            var price = NSUserDefaults.standardUserDefaults().valueForKey("maxFilterPrice") as! Int
            return price
        }else{
            NSUserDefaults.standardUserDefaults().setObject(self.maxFilterPrice, forKey: "maxFilterPrice")
            return self.maxFilterPrice
        }
    }
    
    func SetMaxFilterPrice(price: Int){
        NSUserDefaults.standardUserDefaults().setObject(price, forKey: "maxFilterPrice")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
    func GetTaxRate() -> Float{
        if NSUserDefaults.standardUserDefaults().valueForKey("taxRate") != nil{
            var ratio = NSUserDefaults.standardUserDefaults().valueForKey("raxRate") as! Float
            return ratio
        }else{
            NSUserDefaults.standardUserDefaults().setObject(self.taxRate, forKey: "taxRate")
            return self.taxRate
        }
    }
    
    func SetTaxRate(ratio: Float){
        NSUserDefaults.standardUserDefaults().setObject(ratio, forKey: "raxRate")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}