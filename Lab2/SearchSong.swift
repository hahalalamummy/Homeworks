//
//  SearchSong.swift
//  Lab2
//
//  Created by Admin on 12/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation

class SearchSong {
    var title: String
    var artist: String
    var link: String
    var score: Double
    init(title: String, artist: String, link: String, score: Double) {
        self.title = title
        self.artist = artist
        self.link = link
        self.score = score
    }
}
