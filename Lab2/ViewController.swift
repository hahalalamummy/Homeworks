import UIKit
import RxSwift
import RxCocoa
import ReachabilitySwift

let url = "https://itunes.apple.com/us/rss/topsongs/limit=50/genre=%d/explicit=true/json"

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var genreIndices = [2,3,4,5,6,7,9,10,11,12,14,15,16,17,18,19,20,21,22,24,34,50,51]
    
    var listUrl:Variable<[String]> = Variable<[String]>([])
    
    var disposeBag = DisposeBag()
    
    let animator = Animator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        
        initListUrl()
        
        
        self.setupCollectionView()
        
        self.navigationController?.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(moveToPlayView), name: NSNotification.Name(rawValue: "moveToPlayView"), object: nil)
    }
    
    func moveToPlayView() {
        let playVC = self.storyboard?.instantiateViewController(withIdentifier: "PlayViewController")
        self.present(playVC!, animated: true, completion: nil)
    }
    
    func initListUrl() {
        for i in genreIndices {
            let string = String(format: url, i)
            listUrl.value.append(string)
        }
    }
    
    func setupCollectionView() {
        
        listUrl.asObservable().bindTo(
            self.collectionView.rx.items(cellIdentifier: "CollectionCell", cellType: CollectionViewCell.self)
            
        ) { (row, url, cell) in
            
            cell.setupUI(url: url, row: self.genreIndices[row])
            
            }.addDisposableTo(self.disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.view.frame.width - 30) / 2, height: self.view.frame.height / 3 )
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SongController") as! SongController
        
        vc.genreIndex = genreIndices[indexPath.row]
        vc.genreName = cell.labelGenre.text
        //detailDiscoverVC.loadView()
        
        
        animator.animationFrame = cell.imageGenre.convert(cell.imageGenre.frame, to: self.view)
        animator.image = cell.imageGenre.image
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
extension ViewController: UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
}
