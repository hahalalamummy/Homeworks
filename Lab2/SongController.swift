import UIKit
import RxSwift
import RxCocoa
import ReachabilitySwift

class SongController: UIViewController {
    
    @IBOutlet weak var imageGenre: UIImageView!
    
    @IBOutlet weak var labelGenre: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    static let shared = SongController()
    
    var genreIndex: Int!
    var genreName: String!
    
    var listSongs: Variable<[Song]> = Variable<[Song]>([])
    
    var disposeBag = DisposeBag()
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var oldRow = -1
    var newRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = labelGenre.text
        
        self.setupInit()
        
        self.tableView.delegate = self
//        self.tableView.dataSource = self
        
        self.tableView.register( UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        self.initListSong()
        
        setupTableView()
        
        self.navigationItem.hidesBackButton = true
        let tapOutGesture = UITapGestureRecognizer(target: self, action: #selector(popView))
        self.imageGenre.isUserInteractionEnabled = true
        self.imageGenre.addGestureRecognizer(tapOutGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(moveToPlayView), name: NSNotification.Name(rawValue: "moveToPlayView"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView),name:NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    
    func reloadTableView(notification: NSNotification){
        self.tableView.reloadData()
    }
    
    func moveToPlayView() {
        let playVC = self.storyboard?.instantiateViewController(withIdentifier: "PlayViewController")
        self.present(playVC!, animated: true, completion: nil)
    }
    
    func popView() {
        navigationController!.popViewController(animated: true)
    }
    
    func setupInit() {
        let image = UIImage(named: "genre-\(genreIndex!)")
        print(genreIndex)
        print(image)
        self.imageGenre.image = image
        self.labelGenre.text = self.genreName
        
    }
    
    func setupTableView(){
        
        listSongs.asObservable().bindTo(
            self.tableView.rx.items(cellIdentifier: "TableViewCell", cellType: TableViewCell.self)
        ) { (row, url, cell) in
            
            cell.setupUI(song: self.listSongs.value[row])
            
            }.addDisposableTo(self.disposeBag)
    }
    
    func initListSong() {
        let genreUrl = String(format: url, self.genreIndex)
        print(genreUrl)
        
        DownloadManager.shared.downloadSong(url: genreUrl) { (songs) in
            for song in songs {
                self.listSongs.value.append(song)
            }
        }
        
    }
}

extension SongController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if oldRow != -1 {
            let oldCell = self.tableView.cellForRow(at: IndexPath(row: self.oldRow, section: 0)) as! TableViewCell
            oldCell.imageChosen.isHidden = true
            oldCell.song.isChosen = false
        }
        
        
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        cell.imageChosen.isHidden = false
        cell.song = listSongs.value[indexPath.row]
        cell.song.isChosen = true
        
        if appDelegate.havingPlayBar == false {
            
            appDelegate.havingPlayBar = true
            let cellRect = tableView.rectForRow(at: indexPath)
            let animationFrame = tableView.convert(cellRect, to: tableView.superview)
            appDelegate.addPlaybarView(animationFrame:animationFrame)
        }
        
        let audioPlayer = AudioPlayer.shared
        audioPlayer.listSong = self.listSongs.value
        audioPlayer.songPosition = indexPath.row
        audioPlayer.setup()
        
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 50))
        
        oldRow=indexPath.row
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        cell.imageChosen.isHidden = true
        cell.song.isChosen = false
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
//        cell.imageChosen.isHidden = true
//        cell.song.isChosen = false
//        return cell
//    }
}
