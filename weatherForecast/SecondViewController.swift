//
//  SecondViewController.swift
//  weatherForecast
//
//  Created by 王阿星 on 2016/11/24.
//  Copyright © 2016年 wanghaixin. All rights reserved.
//

import UIKit
import CoreLocation

class SecondViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var state: UILabel!
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation!
    var lock = NSLock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //定位精确度（最高）一般有电源接入，比较耗电
        //kCLLocationAccuracyNearestTenMeters;//精确到10米
        locationManager.distanceFilter = 50
        //设备移动后获得定位的最小距离（适合用来采集运动的定位）
        locationManager.requestWhenInUseAuthorization()
        //弹出用户授权对话框，使用程序期间授权（ios8后)
        //requestAlwaysAuthorization;//始终授权
        locationManager.startUpdatingLocation()
        print("开始定位》》》")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //委托传回定位，获取最后一个
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lock.lock()
        //取得locations数组的最后一个
        let location:CLLocation = locations[locations.count-1]
        currentLocation = locations.last!
//        tv.text = "定位经纬度为：\(location.coordinate.latitude) \(location.coordinate.longitude)"
        lonLatToCity()
        //停止定位
        locationManager.stopUpdatingLocation()
        lock.unlock()
    }
    
    func lonLatToCity() {
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currentLocation) { (placemark, error) -> Void in
            
            if(error == nil)
            {
                let array = placemark! as NSArray
                let mark = array.firstObject as! CLPlacemark
                //城市
                var city: String = (mark.addressDictionary! as NSDictionary).value(forKey: "City") as! String
                print(city)
                //国家
                let country: NSString = (mark.addressDictionary! as NSDictionary).value(forKey: "Country") as! NSString
                print(country)
                //国家编码
                let CountryCode: NSString = (mark.addressDictionary! as NSDictionary).value(forKey: "CountryCode") as! NSString
                print(CountryCode)
                //街道位置
                let FormattedAddressLines: NSString = ((mark.addressDictionary! as NSDictionary).value(forKey: "FormattedAddressLines") as AnyObject).firstObject as! NSString
                print(FormattedAddressLines)
                //具体位置
                let Name: NSString = (mark.addressDictionary! as NSDictionary).value(forKey: "Name") as! NSString
                print(Name)
                //省
                var State: String = (mark.addressDictionary! as NSDictionary).value(forKey: "State") as! String
                print(State)
                //区
                let SubLocality: NSString = (mark.addressDictionary! as NSDictionary).value(forKey: "SubLocality") as! NSString
                print(SubLocality)
                
                self.state.text = "\(State) \(SubLocality)"
                
            }
            else
            {
                print("GG")
            }
        }
    }

}

