//
//  ViewController.swift
//  quan ly
//
//  Created by Admin on 10/26/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var classTableView: UITableView!
    
    var classes = [ClassesEntity]()
    var isViewingCreatClassViewController: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.classTableView.delegate = self
        self.classTableView.dataSource = self
        title = "Classes"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
        classTableView.reloadData()
    }
    
    func loadData() {
        guard let classes = ClassDataManager.shared.listAllClasses()
            else {
                return
        }
        self.classes = classes
    }
    
    @IBAction func addClassButton(_ sender: AnyObject) { // đi đến CreateClassViewController
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        
//        let createClassViewController = storyBoard.instantiateViewController(withIdentifier: "CreateClassViewController") as! CreateClassViewController
//        
//        self.present(createClassViewController, animated:true, completion:nil)
        if !isViewingCreatClassViewController {
            
            let blurView = UIView()
            blurView.frame = self.view.frame
            blurView.backgroundColor = UIColor.clear
            self.view.addSubview(blurView)
            blurView.tag = 101
            
            let createClassViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateClassViewController") as! CreateClassViewController
            self.addChildViewController(createClassViewController)
            //            createClassViewController.view.frame = CGRect(x: 20, y: 130, width: self.view.frame.width - 40, height: 300)
            
            createClassViewController.didMove(toParentViewController: self)
            blurView.addSubview(createClassViewController.view)
            
            isViewingCreatClassViewController = true
        } else {
            if let createClassViewController = self.childViewControllers[0] as? CreateClassViewController {
                createClassViewController.removeFromParentViewController()
                createClassViewController.view.removeFromSuperview()
                isViewingCreatClassViewController = false
            }
            for view in self.view.subviews {
                if view.tag == 101 {
                    //view.removeFromSuperview()
                }
            }
            
            self.loadData()
            classTableView.reloadData()
            
        }
    }
    
    //MARK: tableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath)
        
        let classLable = cell.contentView.viewWithTag(100) as! UILabel
        let numberOfStudentLable = cell.contentView.viewWithTag(101) as! UILabel
        
        classLable.text = classes[indexPath.row].name
        
        if let numberStudents = classes[indexPath.row].containStudent?.count {
            numberOfStudentLable.text = String(describing: numberStudents)
        } else {
            numberOfStudentLable.text = "0"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .destructive, title: "DELETE") { (action, index) in
            let classIT = self.classes[indexPath.row]
            ClassDataManager.shared.deleteClass(classIT: classIT)
            self.loadData()
            self.classTableView.reloadData()
        }
        edit.backgroundColor = UIColor(red: 200/255, green: 123/255, blue: 100/255, alpha: 1)
        
        return [edit]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // đi đến StudentViewController
        let studentVC = self.storyboard?.instantiateViewController(withIdentifier: "StudentViewController") as! StudentViewController
        studentVC.classIT = classes[indexPath.row]
        self.navigationController?.pushViewController(studentVC, animated: true)
    }
}

