//
//  StudentViewController.swift
//  quan ly
//
//  Created by Admin on 10/26/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var studentTableView: UITableView!
    
//    @IBOutlet weak var picture: UIImageView!
//    
//    @IBOutlet weak var nameLabel: UILabel!
//    
//    @IBOutlet weak var birthdayLabel: UILabel!
//    
//    @IBOutlet weak var addressLabel: UILabel!
    
    
    var classIT: ClassesEntity!
    var students = [StudentsEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavigationBarButton()
        studentTableView.delegate = self
        studentTableView.dataSource = self
        
        title = "Student"
        studentTableView.tableFooterView = UIView()
    }
    
    func addNavigationBarButton() {
        //        let buttonCreateStudent = UIBarButtonItem(image: UIImage(named: "addButton"), style: .plain, target: self, action: #selector(showViewCreateNewStudent))
        let buttonCreate = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        //buttonCreate.setImage(UIImage(named: "addButton"), for: .normal)
        buttonCreate.setTitle("Add", for: .normal)
        buttonCreate.setTitleColor(UIColor.blue, for: .normal)
        buttonCreate.addTarget(self, action: #selector(showViewCreateNewStudent), for: .touchUpInside)
        let rightBarItem = UIBarButtonItem()
        rightBarItem.customView = buttonCreate
        
        self.navigationItem.rightBarButtonItems = [rightBarItem]
    }
    
    func showViewCreateNewStudent() { // đi đến CreateStudentViewController
        let createStudentVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateStudentViewController") as! CreateStudentViewController
        
        createStudentVC.classIT = self.classIT
        
        self.navigationController?.pushViewController(createStudentVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
        studentTableView.reloadData()
    }
    
    func loadData() {
        students.removeAll()
        if (classIT.containStudent?.count)! > 0 {
            for student in classIT.containStudent! {
                students.append(student as! StudentsEntity)
            }
        }
    }
    
    // MARK: tableView
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .destructive, title: "DELETE") { (action, index) in
            StudentDataManager.shared.deleteStudent(student: self.students[indexPath.row])
            self.loadData()
            self.studentTableView.reloadData()
        }
        edit.backgroundColor = UIColor(red: 200/255, green: 123/255, blue: 100/255, alpha: 1)
        
        return [edit]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studentTableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)
        
        let student = students[indexPath.row]
        
        let imageLable = cell.contentView.viewWithTag(100) as! UIImageView
        let nameLable = cell.contentView.viewWithTag(101) as! UILabel
        let birthdayLable = cell.contentView.viewWithTag(102) as! UILabel
        let addressLable = cell.contentView.viewWithTag(103) as! UILabel
        
        
        imageLable.image = UIImage(data: student.picture as! Data)
        imageLable.clipsToBounds = true
        
        nameLable.text = student.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        birthdayLable.text = dateFormatter.string(from: student.dateOfBirth as! Date)
        
        addressLable.text = student.address
        
        return cell
    }

}
