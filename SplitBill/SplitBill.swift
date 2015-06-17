//
//  SplitBill.swift
//  SplitBill
//
//  Created by Xinyi Yin on 6/15/15.
//  Copyright (c) 2015 Xinyi Yin. All rights reserved.
//

import Foundation

struct Option{
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
    var orignialPrices:[Float]
    var taxRate:Float
    
    override init(){
        self.orignialPrices = [Float]()
        self.taxRate = 1.0
    }
    
    func SetOriginalPrice(prices:[Float]){
        self.orignialPrices = prices
    }
    
    func SetTaxRate(r:Float){
        self.taxRate = r
    }
    
    func PrintOriginalPrice(){
        println("original prices: \(self.orignialPrices)")
    }
    
    func Split(){
        var shouldPay:[Float] = self.orignialPrices.map{return $0*(1+self.taxRate*2)}
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
        for c in combinations{
            options.append(Option(originalPrices: shouldPay, payMoney: c))
        }
        return options
    }
}