//
//  AllNote.swift
//  weatherForecast
//
//  Created by 王煜 on 2016/11/30.
//  Copyright © 2016年 wanghaixin. All rights reserved.
//

import UIKit

class AllNote: NSObject {
    
    var state: String?
    var noteURL: URL?
    var noteInfo: NSData? {
        //computed property
        get{
            if noteData == nil{
                fetchAsync()
                return nil
            }
            else{
                return noteData
            }
        }
    }
    var isFetching = false
    
    private func fetchAsync(){
        if !isFetching,let url=noteURL{
            print("start feteching weatherInfo \(self.noteURL)")
            isFetching=true;
            DispatchQueue.global(qos: .userInitiated).async {[weak self] in
                do{
                    let imageData=try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        if let strongSelf = self {
                            strongSelf.noteData = imageData as NSData?
                            NotificationCenter.default.post(name: NSNotification.Name("NoteFetched"), object: strongSelf)
                            strongSelf.isFetching=false
                        }
                    }
                    
                }
                catch{
                    print("error fetching notes")
                    DispatchQueue.main.async {
                        if let strongSelf=self{
                            strongSelf.isFetching=false
                        }
                    }
                }
            }
        }
    }
    
    init(url:String) {
        self.noteURL=URL(string:url)
        print("init notes \(noteURL)")
        super.init()
    }
    
    private var noteData: NSData?

}
