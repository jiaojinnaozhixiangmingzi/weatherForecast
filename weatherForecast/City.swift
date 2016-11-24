//
//  City.swift
//  weatherForecast
//
//  Created by 王阿星 on 2016/11/24.
//  Copyright © 2016年 wanghaixin. All rights reserved.
//

import Foundation
import UIKit

class City: NSObject {
    
    var cityNum: String//城市编号，用以请求天气信息
    //var photo: UIImage?
    var cityName: String?//城市名字
    var weatherinfo: WeatherInfo?
    
    init?(cityNum: String, cityName: String?, weatherinfo: WeatherInfo?) {//带三个参数的构造函数
        
        if cityNum.isEmpty {
            return nil
        }
        self.cityNum = cityNum
        self.cityName = cityName
        self.weatherinfo = weatherinfo
        super.init()
    }
    convenience init?(_ name: String)//带！必填函数的简略构造函数
    {
        self.init(cityNum: name,cityName: nil,weatherinfo: nil)
    }
    convenience init?(_ cityNum: String,_ cityName: String,_ weatherinfo: WeatherInfo)//带！必填函数的简略构造函数
    {
        self.init(cityNum: cityNum,cityName: cityName,weatherinfo: weatherinfo)
    }
}
