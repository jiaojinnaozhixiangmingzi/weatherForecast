//
//  ViewControllerExtensions.swift
//  weatherForecast
//
//  Created by 王煜 on 2016/11/29.
//  Copyright © 2016年 wanghaixin. All rights reserved.
//

import UIKit
import  Foundation

extension AddTableViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.countrySearchController.isActive {
            return self.searchArray.count
        } else {
            return self.schoolArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "MyCell"
            //同一形式的单元格重复使用，在声明时已注册
            let cell = tableView.dequeueReusableCell(withIdentifier: identify,
                                                     for: indexPath)
            
            if self.countrySearchController.isActive {
                cell.textLabel?.text = self.searchArray[indexPath.row]
                return cell
            } else {
                cell.textLabel?.text = self.schoolArray[indexPath.row]
                return cell
            }
    }
}

extension AddTableViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = self.schoolArray[indexPath.row]
        self.performSegue(withIdentifier: "SaveToList", sender: city)
    }
    
    //在这个方法中给新页面传递参数
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveToList"{
            
            let indexPath = tableView.indexPathForSelectedRow//先获取用户
            let detailWeatherViewController = segue.destination as!
            ListTableViewController
            let city:City =  City("101010100",sender as! String?)!
            
            for cityinmap in citysMap {//遍历城市、代码对应数组
                if  cityinmap?.cityName == city.cityName{//从地点map中获取城市代码
                    city.cityNum = (cityinmap?.cityNum)!//赋值给city
                    break
                }
            }
            //todo这个地方需要写入数据库，写入之前先判断数据库中是否已经有此收藏城市
            
            //            cityMO1.cityid = Int64(city.cityid!)
            //            cityMO11.cityNum = city.cityNum
            //            cityMO1.cityno = city.cityno
            //            cityMO11.cityName = city.cityName
            //            cityMO1.weaid = city.weaid
            //            cityMO1.week = city.week
            //            cityMO1.days = city.days
            //            cityMO1.temperature = city.temperature
            //            cityMO1.temperature_curr = city.temperature_curr
            //            cityMO1.humidity = city.humidity
            //            cityMO1.weather = city.weather
            //            cityMO1.wind = city.wind
            //            cityMO1.winp = city.winp
            //            cityMO1.temp_high = Int64(city.temp_high!)
            //            cityMO1.temp_low = Int64(city.temp_low!)
            //            cityMO1.temp_curr = Int64(city.temp_curr!)
            
            let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
            
            
            
            let fetchedList = appDelegate?.fetchContext()//这是数组中现存的数据
            //acqList += fetchedList
            var isexisting = false
            for cityMO in fetchedList! {//遍历数组
                print("\(cityMO.cityName)")
                print("\(city.cityName)")
                if  city.cityName == cityMO.cityName {//已经存在此城市，则不进行插入
                    isexisting = true
                }
            }
            if isexisting == false{
                self.city11 = appDelegate?.addToContext(cityNum: city.cityNum, cityName: city.cityName, weaid: city.weaid, days: "", week: "", cityno: "", cityid: 0, temperature: "", temperature_curr: "", humidity: "" , weather: "", wind: "", winp: "", temp_high: 0, temp_low: 0, temp_curr: 0)
                
                let url=URL(string: "http://api.k780.com:88/?app=weather.today&weaid=\(city.cityNum)&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json")
                
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
                        city11?.temperature_curr = temperature_curr as! String?//给对象中的数据赋值
                        city11?.temperature = temperature as! String?
                        city11?.humidity = humidity as! String?
                        city11?.weather = weather as! String?
                        city11?.winp = winp as! String?
                        city11?.wind = wind as! String?
                        city11?.weaid = weaid as! String?
                        
                        //                        acqList.append(cityMO)
                        
                    }
                    // tv!.text="城市:\(city!)\n温度：\(temp!)"
                }catch{
                }
            }
            //detailWeatherViewController.city = city11
            //            let detailWeatherViewController = segue.destination as? DetailWeatherViewController {//把此segue的目标Cotroller
            //                print("!!!!")
            //                // detailWeatherViewController?.city = schoolArray[(indexPath?.row)!]//先把此对象赋给DetailWeatherViewController
            //            }
            //let controller = segue.destination
            //controller.city = schoolArray[indexPath.row]//先把此对象赋
        }
    }
}

extension AddTableViewController: UISearchResultsUpdating
{
    //实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
        self.searchArray = self.schoolArray.filter { (school) -> Bool in
            return school.contains(searchController.searchBar.text!)
        }
    }
}
