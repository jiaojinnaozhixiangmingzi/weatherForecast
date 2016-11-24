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
    var acqList = [City("101010100","北京",WeatherInfo("6c")!), City("101020100","上海",WeatherInfo("6c")!), City("101190101","南京",WeatherInfo("6c")!), City("101110101","西安",WeatherInfo("6c")!), City("101210101","杭州",WeatherInfo("6c")!), City("101280101","广州",WeatherInfo("6c")!), City("101280601","深圳",WeatherInfo("6c")!), City("101030100","天津",WeatherInfo("6c")!), City("101120101","济南",WeatherInfo("6c")!)]
    
    override func viewDidLoad() {//初始化
        super.viewDidLoad()
        for city in acqList {
            if let cityNum = city?.cityNum {
                //city?.cityNum = UIImage(named: name)
                //city?.weatherinfo = "This is a memo for " + name
            } }

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
        cell.textLabel?.text = city?.cityName//大标签
        cell.detailTextLabel?.text = city?.cityNum//小标签
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
