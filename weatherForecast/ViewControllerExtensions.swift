//
//  ViewControllerExtensions.swift
//  weatherForecast
//
//  Created by 王阿星 on 2016/11/29.
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
        self.performSegue(withIdentifier: "AddCity", sender: city)
    }
    //在这个方法中给新页面传递参数
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddCity"{
            
            let indexPath = tableView.indexPathForSelectedRow//先获取用户
            let detailWeatherViewController = segue.destination as!
            DetailWeatherViewController
            let city:City =  City("101010100",sender as! String?)!
            for cityinmap in citysMap {//遍历城市、代码对应数组
                if  cityinmap?.cityName == city.cityName{//从地点map中获取城市代码
                    city.cityNum = (cityinmap?.cityNum)!//赋值给city
                }
            }
            print(city.cityNum)
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
                    city.temperature_curr = temperature_curr as! String?//给对象中的数据赋值
                    city.temperature = temperature as! String?
                    city.humidity = humidity as! String?
                    city.weather = weather as! String?
                    city.winp = winp as! String?
                    city.wind = wind as! String?
                    city.weaid = weaid as! String?
                }
                // tv!.text="城市:\(city!)\n温度：\(temp!)"
            }catch{
            }
            //todo这个地方需要写入数据库，写入之前先判断数据库中是否已经有此收藏城市
            detailWeatherViewController.city = city
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
