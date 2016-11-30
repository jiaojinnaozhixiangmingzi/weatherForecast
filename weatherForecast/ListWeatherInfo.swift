//
//  listWeatherInfo.swift
//  weatherForecast
//
//  Created by 王阿星 on 2016/11/30.
//  Copyright © 2016年 wanghaixin. All rights reserved.
//

import UIKit

class ListWeatherInfo: NSObject {
    var imageURL: URL?
    var cityNum: String?
    
    var weatherinfo: NSData? {
        //computed property
        get{
            if weatherData == nil{
                fetchAsync()
                return nil
            }
            else{
                return weatherData
            }
        }
    }
    var isFetching = false
    
    private func fetchAsync(){
        if !isFetching,let url=imageURL{
            print("start feteching weatherInfo \(self.imageURL)")
            isFetching=true;
            DispatchQueue.global(qos: .userInitiated).async {[weak self] in
                do{
                    let imageData=try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        if let strongSelf = self {
                            strongSelf.weatherData = imageData as NSData?
                            NotificationCenter.default.post(name: NSNotification.Name("ImageFetched"), object: strongSelf)
                            strongSelf.isFetching=false
                        }
                    }
                    
                }
                catch{
                    print("error fetching image")
                    DispatchQueue.main.async {
                        if let strongSelf=self{
                            strongSelf.isFetching=false
                        }
                    }
                }
            }
        }
    }
    init(url:String) {
        self.imageURL=URL(string:url)
        //self.cityNum = cityNum
        print("init image \(imageURL)")
        super.init()
    }
    
    private var weatherData: NSData?
}
