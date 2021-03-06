//
//  CollectionViewCell.swift
//  Lab2
//
//  Created by Admin on 11/29/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageGenre: UIImageView!
    
    @IBOutlet weak var labelGenre: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelGenre.isHidden = true
    }
    
    func setupUI(url: String, row: Int) {
        
        self.isUserInteractionEnabled = false
        self.activityIndicator.startAnimating()
        DownloadManager.shared.downloadGenre(url: url) { (title) in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.labelGenre.isHidden = false
            self.labelGenre.text = title
            self.imageGenre.image = UIImage(named: "genre-\(row)")
            print("genre-\(row)")
            self.isUserInteractionEnabled = true
        }
    }
}
