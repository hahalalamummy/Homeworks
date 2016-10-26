//
//  StudentDataManager.swift
//  quan ly
//
//  Created by Admin on 10/26/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import CoreData

class StudentDataManager {
    static let shared: StudentDataManager = StudentDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "quan ly")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func creatNewStudent(name:String, address:String, dateOfBirth:NSDate, picture:NSData, classes: ClassesEntity) {
        
        let context = self.persistentContainer.viewContext
        let student = StudentsEntity(context: context)
        
        student.name = name
        student.address = address
        student.dateOfBirth = dateOfBirth
        student.picture = picture
        
        student.addToStudyAt(classes)
        classes.addToContainStudent(student)
        
        DatabaseController.saveContext()
    }
    
    func deleteStudent(student: StudentsEntity) {
        let context = self.persistentContainer.viewContext
        context.delete(student)
        
        DatabaseController.saveContext()
    }
    
    
}
