//
//  SplitBill.swift
//  SplitBill
//
//  Created by Xinyi Yin on 6/15/15.
//  Copyright (c) 2015 Xinyi Yin. All rights reserved.
//

import Foundation


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
        println("original prices:")
        for price in self.orignialPrices{
            println(price)
        }
    }
    
    func Split(){
        var shouldPay:[Float] = self.orignialPrices.map{return $0*(1+self.taxRate*2)}
        println(shouldPay)
        var options:Array<[Int]> = shouldPay.map{return [Int(floor($0)), Int(ceil($0))]}
        var combinations:Array<[Int]> = self.GetCombinations(options)
        for c in combinations{
            println(c)
            println(c.reduce(0, combine: +))
        }
    }
    
    func GetCombinations(options:Array<[Int]>) -> Array<[Int]>{
        var combinations:Array<[Int]> = Array<[Int]>()
        for option in options{
            if combinations.count==0{
                for value in option{
                    var path:[Int] = [Int]()
                    path.append(value)
                    combinations.append(path)
                }
            }else{
                var cnt = combinations.count
                for c in combinations{
                    for value in option{
                        var tmp:[Int] = c
                        tmp.append(value)
                        combinations.append(tmp)
                    }
                }
                combinations.removeRange(0..<cnt)
            }
        }
        return combinations
    }
}