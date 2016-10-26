//
//  ClassDataManager.swift
//  quan ly
//
//  Created by Admin on 10/26/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import CoreData

class ClassDataManager {
    static let shared: ClassDataManager = ClassDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "quan ly")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func creatNewClass(name:String) {
        
        let context = self.persistentContainer.viewContext
        
        let classIT = ClassesEntity(context: context)
        classIT.name = name
        
        DatabaseController.saveContext()
    }
    
    func addStudentToClass(student: StudentsEntity, class_: ClassesEntity) {
        class_.containStudent?.adding(student)
    }
    
    func deleteClass(classIT: ClassesEntity) {
        let context = self.persistentContainer.viewContext
        context.delete(classIT)
        
        DatabaseController.saveContext()
    }
    
    func listAllClasses() -> [ClassesEntity]? {
        
        
        let context = self.persistentContainer.viewContext
        
        do {
            let fetchResults = try context.fetch(ClassesEntity.fetchRequest())
            return fetchResults as? [ClassesEntity]
        } catch {
            print(error)
            return nil
        }
    }
}
