//
//  SongController.swift
//  Lab2
//
//  Created by Admin on 11/27/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxCocoa
import RxSwift
import ReachabilitySwift

class SongController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var json: JSON = []
    
    var genreIndex: Int!
    var genreName: String!
    var genrePicture: UIImage!
    
    @IBOutlet weak var genreImage: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        genreLabel.text = genreName
        genreImage.image = genrePicture
    }
    
//    func setupTableView(){
//        
//        listSongs.asObservable().bindTo(
//            self.tableView.rx.items(cellIdentifier: "TableViewCell", cellType: TableViewCell.self)
//        ) { (row, url, cell) in
//            
//            cell.setupUI(song: self.listSongs.value[row])
//            
//            }.addDisposableTo(self.disposeBag)
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableViewCell
        //cell.json = self.json
        let genreUrl = String(format: url, self.genreIndex)
        cell.setupUI(url: genreUrl, row: indexPath.row)
        
        return cell
    }
    
}
