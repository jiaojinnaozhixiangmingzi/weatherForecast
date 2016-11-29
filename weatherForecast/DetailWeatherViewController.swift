//
//  DetailWeatherViewController.swift
//  weatherForecast
//
//  Created by 王阿星 on 2016/11/25.
//  Copyright © 2016年 wanghaixin. All rights reserved.
//

import UIKit

class DetailWeatherViewController: UIViewController {
    
    var city: CityMO?//初始化一个城市对象
    @IBOutlet weak var weatherOffutherWeatherImageView1: UIImageView!
    
    @IBOutlet weak var tempOffutherWeatherLabel2: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempOffutherWeatherLabel5: UILabel!
    @IBOutlet weak var tempOffutherWeatherLabel4: UILabel!
    @IBOutlet weak var tempOffutherWeatherLabel3: UILabel!
    @IBOutlet weak var tempOffutherWeatherLabel1: UILabel!
    @IBOutlet weak var weatherOffutherWeatherImageView5: UIImageView!
    @IBOutlet weak var weatherOffutherWeatherImageView4: UIImageView!
    @IBOutlet weak var weatherOffutherWeatherImageView3: UIImageView!
    @IBOutlet weak var weatherOffutherWeatherImageView2: UIImageView!
    @IBOutlet weak var winpOfTodayImageView: UIImageView!
    @IBOutlet weak var currentTempretureLabel: UILabel!
    @IBOutlet weak var weekdayOffutherWeatherLabel5: UILabel!
    @IBOutlet weak var weekdayOffutherWeatherLabel4: UILabel!
    @IBOutlet weak var lowToHighTempretureLable: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var winpOfTodayLabel: UILabel!
    @IBOutlet weak var windOfTodayImageView: UIImageView!
    @IBOutlet weak var weekdayOffutherWeatherLabel1: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var windOfTodayLabel: UILabel!
    @IBOutlet weak var weekdayOffutherWeatherLabel2: UILabel!
    @IBOutlet weak var weekdayOffutherWeatherLabel3: UILabel!
    @IBOutlet weak var chanceOfRainImageView: UIImageView!
    @IBOutlet weak var chanceOfRainLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        cityNameLabel.text = city?.name if let photo = person?.photo {
        //            photoImageView.image = photo
        //        } else {
        //            photoImageView.image = UIImage(named:"photoalbum")
        //        }
        cityNameLabel.text = city?.cityName//city从prepare中取出，先把城市名字显示在界面上
        lowToHighTempretureLable.text = city?.temperature
        winpOfTodayLabel.text = city?.winp
        windOfTodayLabel.text = city?.humidity
        chanceOfRainLabel.text = city?.wind
        currentTempretureLabel.text = city?.temperature_curr
        weatherLabel.text = city?.weather
        weatherIconImageView.image = UIImage(named: (city?.weather)!)
        //cell.photoImageView.image = UIImage(data: photoData as Data)
        
        if let weaid = city?.weaid{//如果weaid不为空
            print(weaid)
            let urlForNextFiveDays = URL(string: "http://api.k780.com:88/?app=weather.future&weaid=\(weaid)&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json")
            do{
                var dataforNext5days=try NSData(contentsOf:urlForNextFiveDays!, options: NSData.ReadingOptions.uncached)
                
                //var strforNext5days=NSString(data:dataforNext5days as Data,encoding:String.Encoding.utf8.rawValue)
                var jsonforNext5days=try JSONSerialization.jsonObject(with: dataforNext5days as Data, options: JSONSerialization.ReadingOptions.allowFragments)
                
                var weatherinfo:Any?=(jsonforNext5days as AnyObject).object(forKey: "result")//先获取weather信息
                //print(weatherinfo)
                var i=0
                for weather in (weatherinfo as? [AnyObject])!{
                    if i == 0{//排除第一天
                        //var ss=(weather as AnyObject).object(forKey: "week")//周
                    }else{//从1开始
                        var weekday = (weather as AnyObject).object(forKey: "week") as! String?//周日
                        if weekday == "星期日"{
                            weekday = "SUN"
                        }else if weekday == "星期六"{
                            weekday = "SAT"
                        }else if weekday == "星期五"{
                            weekday = "FRI"
                        }else if weekday == "星期四"{
                            weekday = "THU"
                        }else if weekday == "星期三"{
                            weekday = "WED"
                        }else if weekday == "星期二"{
                            weekday = "TUE"
                        }else if weekday == "星期一"{
                            weekday = "MON"
                        }
                        let temperature_high = (weather as AnyObject).object(forKey: "temp_high") as! String?//高温
                        let temperature_low = (weather as AnyObject).object(forKey: "temp_low") as! String?//低温
                        if i==1 {//未来第1天
                            weekdayOffutherWeatherLabel1.text = weekday
                            tempOffutherWeatherLabel1.text = temperature_high! + "˚/" + temperature_low! + "˚"
                        }else if i == 2{
                            weekdayOffutherWeatherLabel2.text = weekday
                            tempOffutherWeatherLabel2.text = temperature_high! + "˚/" + temperature_low! + "˚"
                        }else if i == 3{
                            weekdayOffutherWeatherLabel3.text = weekday
                            tempOffutherWeatherLabel3.text = temperature_high! + "˚/" + temperature_low! + "˚"
                        }else if i == 4{
                            weekdayOffutherWeatherLabel4.text = weekday
                            tempOffutherWeatherLabel4.text = temperature_high! + "˚/" + temperature_low! + "˚"
                        }else if i == 5{
                            weekdayOffutherWeatherLabel5.text = weekday
                            tempOffutherWeatherLabel5.text = temperature_high! + "˚/" + temperature_low! + "˚"
                        }
                    }
                    i+=1
                }
            }catch{
            }
        }
        //navigationItem.title = city?.cityName
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
