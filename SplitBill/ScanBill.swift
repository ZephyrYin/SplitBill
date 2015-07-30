//
//  ScanBill.swift
//  SplitBill
//
//  Created by Xinyi Yin on 6/25/15.
//  Copyright (c) 2015 Xinyi Yin. All rights reserved.
//

import Foundation

struct Item {
    var name:String
    var price:Float
}

class ScanBill:NSObject, G8TesseractDelegate{
    var tesseract:G8Tesseract
    override init(){
        self.tesseract = G8Tesseract(language:"eng")
        //self.tesseract.delegate = self
    }
    
    func getPriceFromImg(img:UIImage) -> [Item]{
        var items:[Item] = [Item]()
        if(img.size.width == 0 || img.size.height == 0){
            return items
        }
        var dValue = DefaultValue()
        var minFilterPrice:Int = dValue.GetMinFilterPrice()
        var maxFilterPrice:Int = dValue.GetMaxFilterPrice()
        self.tesseract.image = img.g8_blackAndWhite()
        self.tesseract.recognize();
        print(self.tesseract.recognizedText)
        var textArray = split(tesseract.recognizedText){$0 == "\n"}
        
        
        for line in textArray{
            println(count(line))
            println(line)
            var tmp:[String] = split(line){$0 == " "}
            if tmp.count < 2{
                continue
            }
            var left:String = "".join(tmp[0...tmp.count-2])
            var right:String = tmp[tmp.count-1]
            var replaced = right.stringByReplacingOccurrencesOfString(",", withString: ".", options: NSStringCompareOptions.LiteralSearch, range: nil)
            replaced = replaced.stringByReplacingOccurrencesOfString("$", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            var price:Float = (replaced as NSString).floatValue
            if Int(price) >= minFilterPrice && Int(price) <= maxFilterPrice{
                var item:Item = Item(name: left, price: (replaced as NSString).floatValue)
                items.append(item)
            }
            
        }
        return items
    }
}