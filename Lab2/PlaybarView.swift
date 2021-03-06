import Foundation
import UIKit
import AVFoundation
import MediaPlayer


class PlaybarView: UIView {
    var song: Song!
    
    @IBOutlet weak var imageSong: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelArtist: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    func initPlay() {
        
        self.progressView.progress = 0
        
        if self.song.image != nil {
            DispatchQueue.main.async {
                self.imageSong.image = self.song.image
                self.labelName.text = self.song.name
                self.labelArtist.text = self.song.artist
                self.imageSong.layer.cornerRadius = self.imageSong.frame.width / 2
                self.imageSong.layer.masksToBounds = true
            }
        } else {
            DownloadManager.shared.downloadImage(url: song.imageUrl) { (image) in
                self.imageSong.image = image
                self.song.image = image
                self.labelName.text = self.song.name
                self.labelArtist.text = self.song.artist
                self.imageSong.layer.cornerRadius = self.imageSong.frame.width / 2
                self.imageSong.layer.masksToBounds = true
            }
        }
        
        AudioPlayer.shared.player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1/2, Int32(NSEC_PER_SEC)), queue: nil) { (time) in
            let duration = CMTimeGetSeconds(AudioPlayer.shared.playerItem.duration)
            self.progressView.progress = Float(CMTimeGetSeconds(time)/duration)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(moveToPlayView))
        
        self.addGestureRecognizer(tapGesture)
    }
    
    func moveToPlayView() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "moveToPlayView"), object: nil)
    }
    
}
