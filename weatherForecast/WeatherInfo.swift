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
    
    var weaid: Int
    //    天气id （每天有一个id，实时接口里的 weaid 和 今天以及未来五天天气接口里的 第一个weaid一样）
    var days: String?
//    日期   （2016-11-24）
    var week: String?
//    星期几  （周四）
    var cityno: String?
//    城市全拼		（beijing）
    var citynm: String?
//    城市名称		（北京）
    var cityid: Int?
//    城市编号		（101010100）
    var temperature: String?
//    气温范围		（4℃/-6℃）
    var temperature_curr: String?
//    当前气温		(只有实时天气有)
    var humidity: String?
//    湿度		（50%）
    var weather: String?
//    天气情况		（晴）
    var wind: String?
//    风向		（西南风）
    var winp: String?
//    风级		（1级）
    var temp_high: Int?
//    最高气温		（4）
    var temp_low: Int?
//    最低气温		（-6）
    var temp_curr: Int?
//    当前气温		（0）
    
    init?(weaid: Int, days: String, week: String, cityno: String, citynm: String, cityid: Int, temperature: String, temperature_curr: String, humidity: String, weather: String, wind: String, winp: String, temp_high: Int, temp_low: Int, temp_curr: Int) {//带所有参数的构造函数
        
        self.weaid = weaid
        self.days = days
        self.week = week
        self.cityno = cityno
        self.citynm = citynm
        self.cityid = cityid
        self.temperature = temperature
        self.temperature_curr = temperature_curr
        self.humidity = humidity
        self.weather = weather
        self.wind = wind
        self.winp = winp
        self.temp_high = temp_high
        self.temp_low = temp_low
        self.temp_curr = temp_curr
        
        super.init()
    }
    convenience init?(_ weaid: Int)//带！必填函数的简略构造函数
    {
        self.init(weaid: weaid, days: "",week: "",cityno: "", citynm: "",cityid: 0, temperature: "", temperature_curr: "", humidity: "",weather: "", wind: "", winp: "", temp_high: 0, temp_low: 0, temp_curr: 0)
    }
}
