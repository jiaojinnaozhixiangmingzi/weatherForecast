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
    
    var noteList = [Note("请稍后","北京","","", UIImage())]

    
    var allNote: AllNote?
    
    //        var noteList = [Note("101010100","北京","","", UIImage()), Note("101020100","上海","","", UIImage()), Note("101190101","南京","","", UIImage()), Note("101110101","西安","","", UIImage())]
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //var i = 1
        for i in 1...9{//做一个10次的循环
            var note =  Note("请稍后","","","",UIImage())
            noteList.append(note)
        }
        print("输出一下整个notelist的长度，正常应该是10\(noteList.count)")
        //获取某地区的所有评论
        getNotesByState(state: state)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //        NotificationCenter.default.removeObserver(self)
    //    }
    //
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
        let url = "http://172.20.10.2:8080/api/notes/getNotesByState"
        self.allNote = AllNote(url: url)//实例化一个对象
        self.allNote?.noteInfo
        NotificationCenter.default.addObserver(self, selector: #selector(self.noteFetch), name:NSNotification.Name("NoteFetched"), object: self.allNote)
    }
    //            let str:String! = String(data: data!, encoding: NSUTF8StringEncoding)
    //            print("str:\(str)")
    //转Json
    //            let jsonData:NSDictionary = try! JSONSerialization.jsonObject(with: noteInfo! as Data, options: .mutableContainers) as! NSDictionary
    
    func noteFetch(){
        var noteInfo = allNote?.noteInfo
        do{
            var jsonData = try JSONSerialization.jsonObject(with: noteInfo as! Data, options: JSONSerialization.ReadingOptions.allowFragments)
            print(jsonData)
            
            var notesInfo:Any!=(jsonData as AnyObject).object(forKey: "data")//获取note信息
            print("开始输出日记信息》》》》")
            var flag = 0
            for oneNote in notesInfo as! [AnyObject]{
                var state = (oneNote as AnyObject).object(forKey: "state")
                var notes = (oneNote as AnyObject).object(forKey: "notes")
                print(notes)
                var path = (oneNote as AnyObject).object(forKey: "path")
                
                var url1 = "http://172.20.10.2:8080/api/getHomeImage?path=\(path)"
                var note:Note = Note(state as! String, notes as! String, url1, "", UIImage())
                print(note)
                //将一条note记录加入到list中
//                self.noteList.append(note)
                self.noteList[flag].state = state as! String
                self.noteList[flag].notes = notes as! String
                self.noteList[flag].imageURL = URL(string: url1)
            
                flag += 1
                
                //                var noteList1 = [note]
                //                self.noteList += noteList1
                print(self.noteList.count)
            }
        }catch{
        }
        //viewDidLoad()
    }
    
}
