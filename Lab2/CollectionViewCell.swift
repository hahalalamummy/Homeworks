//
//  CollectionViewCell.swift
//  Lab2
//
//  Created by Admin on 11/29/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import SwiftyJSON

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageGenre: UIImageView!
    @IBOutlet weak var labelGenre: UILabel!
    
    var json: JSON = []
    var url: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI(url: String, row: Int) {
        DownloadManager.shared.download(url: url) { (json) in
            
            let feed = json["feed"]
            let title = feed["title"]
            guard let label = title["label"].string else {
                return
            }
            let genreName = label.replacingOccurrences(of: "iTunes Store: Top Songs in " , with: "")
            
            self.labelGenre.text = genreName
            self.imageGenre.image = UIImage(named: "genre-\(row)")
            self.url = url
            self.json = json
            print("genre-\(row)")
        }
    }
}
