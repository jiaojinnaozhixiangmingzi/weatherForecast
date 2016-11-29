//
//  Note.swift
//  weatherForecast
//
//  Created by 王煜 on 2016/11/29.
//  Copyright © 2016年 wanghaixin. All rights reserved.
//

import UIKit
import Foundation

class Note: NSObject {
    
    var state: String
    var notes: String?
    var imageName: String?
    var imageURL: URL?
//    var time: Data? 

    var image: UIImage?{
        if imageData != nil{
            return UIImage(data: imageData!)
        } else {
            fetchAsync() //start asynchronous image fetching from the Internet
            return UIImage(named: "photoalbum")
        }
    }
    // stores the image data 
    private var imageData: Data?
    var isFetching = false
    
    init(_ state1: String, _ note: String, _ url: String, _ name: String) {
        state = state1
        notes = note
        imageURL = URL(string: url)
        imageName = name
        print("init image \(imageName)")
        super.init()
    }
    
    func fetchAsync(){
        if !isFetching, let url = imageURL {
            print("start feteching image \(self.imageName)")
            isFetching = true
            DispatchQueue.global(qos: .userInitiated).async() { [weak self] in
                do {
                    let imageData = try Data(contentsOf: url)
                    print("received data for image \(self?.imageName)")
                    DispatchQueue.main.async {
                        if let strongSelf = self {
                            strongSelf.imageData = imageData
                            NotificationCenter.default.post(name: NSNotification.Name("ImageFetched"), object: strongSelf)
                            strongSelf.isFetching = false
                        }
                    }
                } catch {
                    print("error fetching image \(self?.imageName) error: \(error)")
                    DispatchQueue.main.async { if let strongSelf = self {
                        strongSelf.isFetching = false }
                    } }
            } }

//        if !isFetching, let url = imageURL {
//            print("start feteching image \(self.imageName)")
//            isFetching = true
//            let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in if let error = error {
//                print("error downloading image \(self?.imageName) error: \(error)")
//                DispatchQueue.main.async { if let strongSelf = self {
//                    strongSelf.isFetching = false }
//                }
//            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
//                let imageData = data {
//                print("received data for image \(self?.imageName)")
//                DispatchQueue.main.async { if let strongSelf = self {
//                    strongSelf.imageData = imageData
//                    NotificationCenter.default.post(name: NSNotification.Name("ImageFetched"), object: strongSelf)
//                    strongSelf.isFetching = false }
//                }
//            } else {
//                print("failed downloading image \(self?.imageName) error: \(response)")
//                DispatchQueue.main.async { if let strongSelf = self {
//                    strongSelf.isFetching = false }
//                } }
//            }
//            dataTask.resume() }
    }
}
