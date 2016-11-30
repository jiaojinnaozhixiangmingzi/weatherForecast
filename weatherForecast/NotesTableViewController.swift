//
//  NotesTableViewController.swift
//  weatherForecast
//
//  Created by 王煜 on 2016/11/28.
//  Copyright © 2016年 wanghaixin. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    var state = "北京市海淀区"
    
    var noteList = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取某地区的所有评论
        getNotesByState(state: state)
        print(noteList)
        for  note in noteList{
            print(note.notes)
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
    //
    //    // MARK: - Table view data source
    //
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return noteList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteList", for: indexPath)
        
        let note = noteList[indexPath.row]
        //        // Configure the cell...
        //        if let photo = city.photo {
        //            cell.imageView?.image = photo
        //        } else {
        //            cell.imageView?.image = UIImage(named:"photoalbum")
        //        }
        cell.textLabel?.text = note.state//大标签
        cell.detailTextLabel?.text = note.notes//小标签
        cell.imageView?.image = note.image//图片
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
    
    func getNotesByState(state: String) {
        //请求URL
        let url:NSURL! = NSURL(string: "http://172.20.10.2:8080/api/notes/getNotesByState")
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url as URL)
        let list  = NSMutableArray()
        //var paramDic = [String: String]()
        var paramDic = ["state": state]
        
        if paramDic.count > 0 {
            //设置为POST请求
            request.httpMethod = "POST"
            //拆分字典,subDic是其中一项，将key与value变成字符串
            for subDic in paramDic {
                let tmpStr = "\(subDic.0)=\(subDic.1)"
                list.add(tmpStr)
            }
            //用&拼接变成字符串的字典各项
            let paramStr = list.componentsJoined(by: "&")
            //UTF8转码，防止汉字符号引起的非法网址
            let paraData = paramStr.data(using: String.Encoding.utf8)
            //设置请求体
            request.httpBody = paraData
        }
        //默认session配置
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        //发起请求
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            //            let str:String! = String(data: data!, encoding: NSUTF8StringEncoding)
            //            print("str:\(str)")
            //转Json
            let jsonData:NSDictionary = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
            
            print(jsonData)
            
            var notesInfo:Any!=(jsonData as AnyObject).object(forKey: "data")//获取note信息
            print("开始输出日记信息》》》》")
            for oneNote in notesInfo as! [AnyObject]{
                var state = (oneNote as AnyObject).object(forKey: "state")
                var notes = (oneNote as AnyObject).object(forKey: "notes")
                print(notes)
                var path = (oneNote as AnyObject).object(forKey: "path")
                
                var url1 = "http://172.20.10.2:8080/api/getHomeImage?path=\(path)"
                var note:Note = Note(state as! String, notes as! String, url1, "", UIImage())
                print(note)
                //将一条note记录加入到list中
                var noteList1 = [note]
                self.noteList += noteList1
                print(self.noteList.count)
            }
        }
        //请求开始
        dataTask.resume()
    }
    
}
