//
//  Song.swift
//  Lab2
//
//  Created by Admin on 12/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import UIKit

class Song {
    var imageUrl: String
    var name: String
    var artist: String
    var image: UIImage!
    var isChosen: Bool!
    
    init(imageUrl: String, name: String, artist: String) {
        self.imageUrl = imageUrl
        self.name = name
        self.artist = artist
        self.isChosen = false
    }
}
