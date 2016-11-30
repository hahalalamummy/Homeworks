//
//  DownloadManager.swift
//  Lab2
//
//  Created by Admin on 11/29/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import AlamofireImage

class DownloadManager {
    
    static let shared = DownloadManager()
    
    func download(url: String, completed: @escaping(_ json: JSON) -> Void) {
        
        guard let genreUrl = URL(string: url) else {
            return
        }
        
        Alamofire.request(genreUrl).responseJSON { (response) in
            
            if let value = response.result.value {
                let json = JSON(value)
                completed(json)
            }
            
        }
        
    }
    
    func downloadImage(url2: String, completed: @escaping(_ image: UIImage) -> Void) {
        Alamofire.request(url2).responseImage { (response) in
            
            if let image = response.result.value {
                print(image)
                completed(image)
            }
        }
        
    }
    
//    func downloadSongName(url: String, sequence: Int, completed: @escaping(_ string: String) -> Void) {
//        
//        guard let genreUrl = URL(string: url) else {
//            return
//        }
//        
//        Alamofire.request(genreUrl).responseJSON { (response) in
//            
//            if let value = response.result.value {
//                let json = JSON(value)
//                
//                let feed = json["feed"]
//                let title = feed["title"]
//                let entry = feed["entry"]
//                let name =
//                completed(genreName)
//            }
//            
//        }
//        
//    }
    
}
