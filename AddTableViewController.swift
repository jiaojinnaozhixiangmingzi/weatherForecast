//
//  AddTableViewController.swift
//  weatherForecast
//
//  Created by 王阿星 on 2016/11/27.
//  Copyright © 2016年 wanghaixin. All rights reserved.
//

import UIKit

class AddTableViewController: UIViewController, UISearchBarDelegate {
    var selectedCellIndexPaths:[NSIndexPath] = []
    var city11: CityMO?
    //@IBOutlet weak var searchBar: UISearchBar!
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
//        print(presentingViewController)
        dismiss(animated: true, completion: nil)
        
        //        if presentingViewController is UINavigationController {
        //            dismiss(animated: true, completion: nil)
        //        } else {
        //            navigationController!.popViewController(animated: true)
    }
    //展示列表
    var tableView: UITableView!
    
    //搜索控制器
    var countrySearchController = UISearchController()
    
    //原始数据集
    let schoolArray = ["北京","上海","天津","重庆","沈阳",
                       "大连","长春","哈尔滨","郑州",
                       "武汉","长沙","广州","深圳","南京",
                       "济南","广州","石家庄"]
    
    //搜索过滤后的结果集
    var searchArray:[String] = [String](){
        didSet  {self.tableView.reloadData()}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表视图
        let tableViewFrame = CGRect(x: 0, y: 20, width: self.view.frame.width,
                                    height: self.view.frame.height-20)
        self.tableView = UITableView(frame: tableViewFrame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "MyCell")
        //self.tableView!.register
        self.view.addSubview(self.tableView!)
        self.tableView!.allowsSelection = true
        //配置搜索控制器
        self.countrySearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self   //两个样例使用不同的代理
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
    }
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("print一下")
        self.tableView!.deselectRow(at: indexPath as IndexPath, animated: false)
        selectedCellIndexPaths = [indexPath]
        // Forces the table view to call heightForRowAtIndexPath
        tableView.reloadRows(at: [indexPath as IndexPath], with: .automatic)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
