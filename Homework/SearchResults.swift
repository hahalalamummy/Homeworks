//
//  SearchResults.swift
//  Homework
//
//  Created by Admin on 11/1/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class SearchResults: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var playBar: UIView!
    @IBOutlet weak var playBarImage: UIImageView!
    @IBOutlet weak var playBarLabel: UILabel!
    @IBOutlet weak var playBarPlayButton: UIButton!
    @IBOutlet weak var playBarSkipButton: UIButton!
    
    @IBOutlet weak var searchMusicImage: UIImageView!
    
    @IBOutlet weak var listSong: UITableView!
    
    var player = AVPlayer()
    
    var trackName = [String]()
    var artistName: [String] = []
    var images: [UIImage] = []
    var soundURL: [URL] = []
    var trackPrice: [Double] = []
    
    var songSequence: Int = 0
    var isPlaying: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playBar.alpha = 0
        
        searchBar.showsScopeBar = true
        searchBar.delegate = self
        
        self.listSong.delegate = self
        self.listSong.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestItunes(search: String) {
        
        
        let stringURL = "https://itunes.apple.com/search?term="+search
        let url = URL(string: stringURL)
        
        let dataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if (error != nil) {
                print(error)
                return
            }
            
            do {
                let jason = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                guard let results = jason["results"] as? [AnyObject] else {
                    return
                }
                
                for i in 0..<20 {
                    guard let resultsArray = results[i] as? [String: AnyObject] else { return }
                    
                    guard let kind = resultsArray["kind"] else { return }
                    if kind as! String == "song" {
                        
                        guard let trackName = resultsArray["trackName"] else { return }
                        self.trackName.append(trackName as! String)
                        
                        guard let artistName = resultsArray["artistName"] else { return }
                        self.artistName.append(artistName as! String)
                        
                        guard let artworkUrl100 = resultsArray["artworkUrl100"] else { return }
                        if let url = NSURL(string: artworkUrl100 as! String) {
                            if let data = NSData(contentsOf: url as URL) {
                                self.images.append(UIImage(data: data as Data)!)
                            }
                        }
                        
                        guard let previewUrl = resultsArray["previewUrl"] else { return }
                        self.soundURL.append(URL(string: previewUrl as! String)!)
                        
                        guard let trackPrice = resultsArray["trackPrice"] else { return }
                        self.trackPrice.append(trackPrice as! Double)
                    }
                }
                
                DispatchQueue.main.async(execute: {() -> Void in
                    self.listSong.reloadData()
                })
                print("reloadData")
                
            } catch let jsonError {
                print(jsonError)
            }
        }
        
        dataTask.resume()
    }
    
    func play() {
        let playerItem = AVPlayerItem(url: soundURL[songSequence])
        self.player = AVPlayer(playerItem: playerItem)
        player.volume = 1.0
        player.play()
        isPlaying = true
    }
    
    //MARK:
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.songSequence = indexPath.row
        playBarImage.image = images[songSequence]
        playBarLabel.text = trackName[songSequence]
        self.play()
        playBar.alpha = 1
        
        let mpic = MPNowPlayingInfoCenter.default()
        mpic.nowPlayingInfo = [
            MPMediaItemPropertyTitle:trackName[songSequence],
            MPMediaItemPropertyArtist:artistName[songSequence],
            MPMediaItemPropertyArtwork: MPMediaItemArtwork(image: images[songSequence])
        ]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count-1
    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = listSong.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    //
    //        let image = cell.contentView.viewWithTag(100) as! UIImageView
    //        let songName = cell.contentView.viewWithTag(101) as! UILabel
    //        let title = cell.contentView.viewWithTag(102) as! UILabel
    //
    //        image.image = self.images[indexPath.row]
    //        songName.text = self.trackName[indexPath.row]
    //        title.text = self.artistName[indexPath.row] + "-" + self.trackName[indexPath.row]
    //
    //        return cell
    //    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listSong.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let image = cell.contentView.viewWithTag(100) as! UIImageView
        let songName = cell.contentView.viewWithTag(101) as! UILabel
        let title = cell.contentView.viewWithTag(102) as! UILabel
        
        if images.count == 0 || images.count < indexPath.row {
            return cell
        }
        
        image.image = self.images[indexPath.row]
        songName.text = self.trackName[indexPath.row]
        title.text = self.artistName[indexPath.row] + "-" + self.trackName[indexPath.row]
        
        return cell
    }
    
    //MARK:
    
    @IBAction func playButton(_ sender: AnyObject) {
        if isPlaying {
            player.pause()
            playBarPlayButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            isPlaying = false
        } else {
            player.play()
            playBarPlayButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            isPlaying = true
        }
        
    }
    
    @IBAction func skipButton(_ sender: AnyObject) {
        songSequence += 1
        if songSequence >= soundURL.count {
            songSequence = 0
        }
        play()
        playBarImage.image = images[songSequence]
        playBarLabel.text = trackName[songSequence]
        isPlaying = true
    }
    
    //MARK:
    
//    @IBOutlet weak var searchBar: UITextField!
    
//    @IBAction func search(_ sender: AnyObject) {
//        let result = searchBar.text?.replacingOccurrences(of: " ", with: "+")
//        requestItunes(search: result!)
//        searchMusicImage.alpha = 0
//        searchBar.resignFirstResponder()
//    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let result = searchBar.text?.replacingOccurrences(of: " ", with: "+")
        requestItunes(search: result!)
        searchMusicImage.alpha = 0
        searchBar.resignFirstResponder()
        trackName.removeAll()
        artistName.removeAll()
        images.removeAll()
        soundURL.removeAll()
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        <#code#>
    }
}
