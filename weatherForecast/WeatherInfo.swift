//
//  WeatherInfo.swift
//  weatherForecast
//
//  Created by 王阿星 on 2016/11/24.
//  Copyright © 2016年 wanghaixin. All rights reserved.
//

import Foundation
import UIKit
class WeatherInfo: NSObject {
    
    weaid 天气id （每天有一个id，实时接口里的 weaid 和 今天以及未来五天天气接口里的 第一个weaid一样）
    days  日期   （2016-11-24）
    week  星期几  （周四）
    cityno  城市全拼		（beijing）
    citynm	城市名称		（北京）
    cityid	城市编号		（101010100）
    temperature  气温范围		（4℃/-6℃）
    temperature_curr	当前气温		(只有实时天气有)
    humidity	湿度		（50%）
    weather    天气情况		（晴）
    wind     风向		（西南风）
    winp     风级		（1级）
    temp_high   最高气温		（4）
    temp_low	最低气温		（-6）
    temp_curr   当前气温		（0）
    
    
    
    var currentTempreture: String?
    //var photo: UIImage?
    var cityName: String?
    //var weatherinfo: WeatherInfo?
    
    init?(currentTempreture: String, cityName: String?) {//带两个参数的构造函数
        
//        if cityNum.isEmpty {
//            return nil
//        }
        self.currentTempreture = currentTempreture
        self.cityName = cityName
        super.init()
    }
    convenience init?(_ currentTempreture: String)//带！必填函数的简略构造函数
    {
        self.init(currentTempreture: currentTempreture,cityName: nil)
    }
}
