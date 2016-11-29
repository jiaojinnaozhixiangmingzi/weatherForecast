//
//  ListTableViewController.swift
//  weatherForecast
//
//  Created by 王阿星 on 2016/11/24.
//  Copyright © 2016年 wanghaixin. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    //    var acqList = ["北京", "上海", "南京", "西安", "济南", "广州", "深圳", "天津", "甘肃"]
//    var acqList = [City("101010100","北京"), City("101020100","上海"), City("101190101","南京"), City("101110101","西安"), City("101210101","杭州"), City("101280101","广州"), City("101280601","深圳"), City("101030100","天津"), City("101120101","济南")]
    
    var acqList = [CityMO]()
    override func viewDidLoad() {//初始化
        super.viewDidLoad()
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate), let fetchedList = appDelegate.fetchContext() {
            acqList += fetchedList }
        
        for cityMO in acqList {//遍历数组
            if let cityNum = cityMO.cityNum {
                //city?.cityNum = UIImage(named: name)
                //city?.weatherinfo = "This is a memo for " + name
                // func loadWeather() {
                let url=URL(string: "http://api.k780.com:88/?app=weather.today&weaid=\(cityNum)&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json")
                
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
                        cityMO.temperature_curr = temperature_curr as! String?//给对象中的数据赋值
                        cityMO.temperature = temperature as! String?
                        cityMO.humidity = humidity as! String?
                        cityMO.weather = weather as! String?
                        cityMO.winp = winp as! String?
                        cityMO.wind = wind as! String?
                        cityMO.weaid = weaid as! String?
                        
                        acqList.append(cityMO)

                    }
                    // tv!.text="城市:\(city!)\n温度：\(temp!)"
                }catch{
                }
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    // MARK: - Table view data source
    //
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return acqList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//每行row显示时都会调用此方法
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        
        let city = acqList[indexPath.row]
        //        // Configure the cell...
        //        if let photo = city.photo {
        //            cell.imageView?.image = photo
        //        } else {
        //            cell.imageView?.image = UIImage(named:"photoalbum")
        //        }
        cell.textLabel?.text = city.cityName//大标签
        cell.detailTextLabel?.text = city.temperature_curr//小标签
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            acqList.remove(at: indexPath.row)//删除数组中此行的对象
//            tableView.deleteRows(at: [indexPath], with: .fade)//界面上显示
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
        
        if editingStyle == .delete {
            // Delete the row from the data source
            let city = acqList[indexPath.row]
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                appDelegate.deleteFromContext(city: city)
                acqList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade) }
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowWeatherDetail",//先判断segue的id
            let indexPath = tableView.indexPathForSelectedRow,//先获取用户点击的数据所在的行数
            let detailWeatherViewController = segue.destination as? DetailWeatherViewController {//把此segue的目标Cotroller
            detailWeatherViewController.city = acqList[indexPath.row]//先把此对象赋给DetailWeatherViewController
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
