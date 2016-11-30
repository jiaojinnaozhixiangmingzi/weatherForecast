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
    
    @IBOutlet weak var nextDayTempeLabel5: UILabel!
    @IBOutlet weak var nextDayTempeLabel4: UILabel!
    @IBOutlet weak var nextDayTempeLabel3: UILabel!
    @IBOutlet weak var nextDayTempeLabel2: UILabel!
    @IBOutlet weak var nextDayTempeLabel1: UILabel!
    @IBOutlet weak var nextDayWeatherImageView5: UIImageView!
    @IBOutlet weak var nextDayWeatherImageView4: UIImageView!
    @IBOutlet weak var nextDayWeatherImageView3: UIImageView!
    @IBOutlet weak var nextDayWeatherImageView2: UIImageView!
    @IBOutlet weak var nextDayWeatherImageView1: UIImageView!
    @IBOutlet weak var nextWeekDayLabel5: UILabel!
    @IBOutlet weak var nextWeekDayLabel4: UILabel!
    @IBOutlet weak var nextWeekDayLabel3: UILabel!
    @IBOutlet weak var nextWeekDayLabel2: UILabel!
    @IBOutlet weak var nextWeekDayLabel1: UILabel!
    @IBOutlet weak var currentWindLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var currentWinpLabel: UILabel!
    
    @IBOutlet weak var rainChanceLabel: UILabel!
    @IBOutlet weak var currentTempeLabel: UILabel!
    @IBOutlet weak var todayTemperLabel: UILabel!
    @IBOutlet weak var state: UILabel!
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation!
    var lock = NSLock()

    var todayWeather: todayWeather?

    var stateToNotes: String?
    
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var weatherinfo = todayWeather?.weatherinfo
//        self.imageView.image=ifImage?.image;
//        self.imageView.sizeToFit();
//        self.scrollView.contentSize=self.imageView.bounds.size
        NotificationCenter.default.addObserver(self, selector: #selector(imageFetched), name:NSNotification.Name("ImageFetched"), object: weatherinfo)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    func imageFetched(){
        var weatherinfo = todayWeather?.weatherinfo
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
                for city in citysMap {//遍历城市、代码对应数组
                    if let cityNum = city?.cityNum {//如果城市代码不为空
                        if SubLocality.components(separatedBy: (city?.cityName)!).count > 1{//海淀区包含海淀二字
                            var cityNum = city?.cityNum
                            print(cityNum)
                            let url=URL(string: "http://api.k780.com:88/?app=weather.today&weaid=\(cityNum!)&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json")
                            
                            do{
                                let data=try NSData(contentsOf:url!, options: NSData.ReadingOptions.uncached)
                                //let str=NSString(data:data as Data,encoding:String.Encoding.utf8.rawValue)
                                let json: Any!=try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments)
                                if let weatherinfo:Any = (json as AnyObject).object(forKey: "result"){//先判断获取到的weather是否为空，然后获取所有weather信息
                                    // print(weatherinfo)
                                    let temperature_curr:Any! = (weatherinfo as AnyObject).object(forKey: "temperature_curr")//当前气温，带符号，显示到界面上
                                    let weaid:Any! = (weatherinfo as AnyObject).object(forKey: "weaid")//获取weatid
                                    let temperature:Any!=(weatherinfo as AnyObject).object(forKey: "temperature")
                                    let humidity:Any!=(weatherinfo as AnyObject).object(forKey: "humidity")
                                    let weather:Any!=(weatherinfo as AnyObject).object(forKey: "weather")
                                    print(weather)
                                    let wind:Any!=(weatherinfo as AnyObject).object(forKey: "wind")
                                    let winp:Any!=(weatherinfo as AnyObject).object(forKey: "winp")
                                    let weathericon:Any! = (weatherinfo as AnyObject).object(forKey: "weather_icon")
                                    
                                    self.todayTemperLabel.text = "\(temperature!)"
                                    self.state.text = "\(State) \(SubLocality)"
                                    
                                    //给传给写日记页面的state赋值
                                    self.stateToNotes = "\(State)\(SubLocality)"
                                    
                                    self.currentWindLabel.text = "\(wind!)"
                                    self.currentTempeLabel.text = "\(temperature_curr!)"
                                    self.rainChanceLabel.text = "\(humidity!)"
                                    self.currentWinpLabel.text = "\(winp!)"
                                }
                                // tv!.text="城市:\(city!)\n温度：\(temp!)"
                            }catch{
                            }
                            break
                        }
                    }
                }
                
                
            }
            else
            {
                print("GG")
            }
        }
    }
    
    @IBAction func unwindToList(segue:UIStoryboardSegue) {
        if segue.identifier == "SaveToList",
            let takeANoteTableViewController = segue.source as? takeANoteTableViewController, let note = takeANoteTableViewController.note {
            var photo = note.image
            var state = note.state
            var notes = note.notes
            var photoName = note.imageName
            upload(img: photo!, state: state, notes: notes!, photoName: photoName!)
        }
    }
    
    //上传
    func upload(img:UIImage, state:String, notes:String, photoName:String)
    {
        
        print("Start upload:>>>>>")
        let data=UIImagePNGRepresentation(img)//把图片转成data
        
        let uploadurl:String="http:/172.20.10.2:8080/api/notes/insertOne"//设置服务器接收地址
        let request=NSMutableURLRequest(url:NSURL(string:uploadurl)! as URL)
        
        
        request.httpMethod="POST"//设置请求方式
        var boundary:String="-------------------21212222222222222222222"
        var contentType:String="multipart/form-data;boundary="+boundary
        request.addValue(contentType, forHTTPHeaderField:"Content-Type")
        var body=NSMutableData()
        
        //        传入一个普通参数
        body.append(NSString(format:"\r\n--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"Content-Disposition:form-data;name=\"state\"\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"Content-Type:text/plain;charset=utf-8\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"\(state)" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"\r\n--\(boundary)" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        //        传入一个普通参数
        body.append(NSString(format:"\r\n--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"Content-Disposition:form-data;name=\"notes\"\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"Content-Type:text/plain;charset=utf-8\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"\(notes)" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"\r\n--\(boundary)" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        body.append(NSString(format:"\r\n--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"Content-Disposition:form-data;name=\"userfile\";filename=\"\(photoName).jpg\"\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"Content-Type:application/octet-stream\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append(data!)
        body.append(NSString(format:"\r\n--\(boundary)" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        
        request.httpBody=body as Data
        let que=OperationQueue()
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: que, completionHandler: {
            (response, data, error) ->Void in
            
            if (error != nil){
                print(error)
            }else{
                //Handle data in NSData type
                let tr:String=NSString(data:data!,encoding:String.Encoding.utf8.rawValue)! as String
                print(tr)
            }
        })
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController. // Pass the selected object to the new view controller.
//        //        print(segue.identifier)
//        //        print(segue.destination)
//        //        let takeANoteTableViewController = segue.destination as? takeANoteTableViewController
//        //        print(takeANoteTableViewController)
//        //        if segue.identifier == "AddNewNote"
//        ////            , let takeANoteTableViewController = segue.destination as? takeANoteTableViewController
//        //        {
//        ////            takeANoteTableViewController.stateToNotes = self.stateToNotes
//        //            print(self.stateToNotes)
//        //        }
//    }}
}

