//: Playground - noun: a place where people can play

import Cocoa

//: Playground - noun: a place where people can play

import Cocoa

//var str = "Hello, playground"
var url=URL(string: "http://api.k780.com:88/?app=weather.future&weaid=1&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json")


do{
    var data=try NSData(contentsOf:url!, options: NSData.ReadingOptions.uncached)
    
    var str=NSString(data:data as Data,encoding:String.Encoding.utf8.rawValue)
    var json=try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments)
    
    var weatherinfo:Any!=(json as AnyObject).object(forKey: "result")//先获取weather信息
    var i=0
    for weather in weatherinfo as! [AnyObject]{
        if i == 0{//排除第一天
            //var ss=(weather as AnyObject).object(forKey: "week")//周
        }else{
            var ss=(weather as AnyObject).object(forKey: "week")//周
        }
        i+=1
    }
    
    
    var weatherArray = [Array<Any>]()
    //weatherArray = (weatherinfo as! AnyObject) as! [Array<Any>]
   
    
    var tempFromLowToHigh:Any!=(weatherinfo as AnyObject).object(forKey: "temperature")//高低温，带符号
    
    var temperature_curr:Any!=(weatherinfo as AnyObject).object(forKey: "temperature_curr")//当前气温，带符号
    
    //    var tempFromLowToHigh:Any!=(weatherinfo as AnyObject).object(forKey: "temperature")
    //
    //    var tempFromLowToHigh:Any!=(weatherinfo as AnyObject).object(forKey: "temperature")
    //
    //    var tempFromLowToHigh:Any!=(weatherinfo as AnyObject).object(forKey: "temperature")
    //
    //    var tempFromLowToHigh:Any!=(weatherinfo as AnyObject).object(forKey: "temperature")
    //
    //    var tempFromLowToHigh:Any!=(weatherinfo as AnyObject).object(forKey: "temperature")
    //
    //    var tempFromLowToHigh:Any!=(weatherinfo as AnyObject).object(forKey: "temperature")
    //
    //    var tempFromLowToHigh:Any!=(weatherinfo as AnyObject).object(forKey: "temperature")
    //
    
}catch{
}
