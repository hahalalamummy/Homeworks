//
//  TableViewCell.swift
//  Lab2
//
//  Created by Admin on 11/27/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
//import AlamofireImage

class TableViewCell: UITableViewCell {
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artist: UILabel!
    
//    var json: JSON = []
    var imgURL: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        self.songImage.layer.cornerRadius = self.songImage.frame.size.width/2
        self.songImage.layer.masksToBounds = true
    }
    
    func setupUI(json: JSON, row: Int) {
        
        let feed = json["feed"]
        let entry = feed["entry"]
        let entrySequence = entry[row]
        
        let name = entrySequence["im:name"]
        guard let nameLabel = name["label"].string else {
            return
        }
        
        let image = entrySequence["im:image"]
        let image0 = image[0]
        guard let imageLabel = image0["label"].string else {
            return
        }
        
        let artist = entrySequence["im:artist"]
        guard let artistLabel = artist["label"].string else {
            return
        }
        
        
        //self.imgURL = imageLabel
        
        DownloadManager.shared.downloadImage(url2: imageLabel) { (image) in
            self.songImage.image = image
            self.songName.text = nameLabel
            self.artist.text = artistLabel
        }
        
//        Alamofire.request(imgURL).responseImage { response in
//            debugPrint(response)
//
//            print(response.request)
//            print(response.response)
//            debugPrint(response.result)
//            
//            if let image = response.result.value {
//                print("image downloaded: \(image)")
//                self.songImage.image = image
//            }
//        }
    }
}
