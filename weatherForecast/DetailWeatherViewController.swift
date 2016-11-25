//
//  DetailWeatherViewController.swift
//  weatherForecast
//
//  Created by 王阿星 on 2016/11/25.
//  Copyright © 2016年 wanghaixin. All rights reserved.
//

import UIKit

class DetailWeatherViewController: UIViewController {

    var city: City?//初始化一个城市对象
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
        lowToHighTempretureLable.text = city?.weatherinfo?.temperature
        winpOfTodayLabel.text = city?.weatherinfo?.winp
        windOfTodayLabel.text = city?.weatherinfo?.humidity
        chanceOfRainLabel.text = city?.weatherinfo?.wind
        currentTempretureLabel.text = city?.weatherinfo?.temperature_curr
        weatherLabel.text = city?.weatherinfo?.weather
        weatherIconImageView.image = UIImage(named: (city?.weatherinfo?.weather)!)
        //cell.photoImageView.image = UIImage(data: photoData as Data)
        let urlForNextFiveDays = URL(string: "http://api.k780.com:88/?app=weather.future&weaid=1&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json")
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
