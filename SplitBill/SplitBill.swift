//
//  SplitBill.swift
//  SplitBill
//
//  Created by Xinyi Yin on 6/15/15.
//  Copyright (c) 2015 Xinyi Yin. All rights reserved.
//

import Foundation

struct Option{
    var names:[String]
    var originalPrices:[Float]
    var payMoney:[Int]
    
    var shouldPay:Float{
        get{
            return originalPrices.reduce(0, combine: +)
        }
    }
    
    var totalPay:Int{
        get{
            return payMoney.reduce(0, combine: +)
        }
    }
    
    var overFlow:Float{
        get{
            return Float(totalPay) - shouldPay
        }
    }
}


class SplitBill:NSObject{
    var dV:DefaultValue
    var orignialPrices:[Float]
    var taxRate:Float
    var tipRatio:Float
    var names:[String]
    
    override init(){
        self.dV = DefaultValue()
        self.orignialPrices = [Float]()
        self.taxRate = self.dV.GetTaxRate()
        self.tipRatio = self.dV.GetDefaultTip()
        println("tax: \(self.taxRate)")
        println("tip: \(self.tipRatio)")
        self.names = [String]()
    }
    
    func SetOriginalPrice(prices:[Float]){
        self.orignialPrices = prices
    }
    
    func SetNames(n:[String]){
        self.names = n
    }
    
    func PrintOriginalPrice(){
        println("original prices: \(self.orignialPrices)")
    }
    
    func Split() -> [Option]{
        var shouldPay:[Float] = self.orignialPrices.map{return $0*(1+self.taxRate + self.tipRatio)}
        println(shouldPay)
        var total:Float = shouldPay.reduce(0, combine: +)
        println("whole price : \(total)")
        
        var options:[Option] = self.GetCombinations(shouldPay)
        options.sort({abs($0.overFlow) < abs($1.overFlow)})
        for option in options{
            print(option.originalPrices)
            print(option.payMoney)
            println("\(option.totalPay) \(option.overFlow)")
        }
        return Array(options)
    }
    
    func GetCombinations(shouldPay:[Float]) -> [Option]{
        var modifiedPrices:Array<[Int]> = shouldPay.map{return [Int(floor($0)), Int(ceil($0))]}
        var combinations:Array<[Int]> = Array<[Int]>()
        for prices in modifiedPrices{
            if combinations.count==0{
                for value in prices{
                    var path:[Int] = [Int]()
                    path.append(value)
                    combinations.append(path)
                }
            }else{
                var cnt = combinations.count
                for c in combinations{
                    for value in prices{
                        var tmp:[Int] = c
                        tmp.append(value)
                        combinations.append(tmp)
                    }
                }
                combinations.removeRange(0..<cnt)
            }
        }
        var options:[Option] = [Option]()
        
        var record = [Int: Int]()
        for c in combinations{
            var total = c.reduce(0, combine: +)
            println(total)
            if record[total] == nil{
                options.append(Option(names: self.names, originalPrices: shouldPay, payMoney: c))
                record[total] = 1
            }
        }
        return options
    }
}