//
//  ClassesEntity+CoreDataProperties.swift
//  quan ly
//
//  Created by Admin on 10/26/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import CoreData

extension ClassesEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClassesEntity> {
        return NSFetchRequest<ClassesEntity>(entityName: "ClassesEntity");
    }

    @NSManaged public var name: String?
    @NSManaged public var containStudent: NSSet?

}

// MARK: Generated accessors for containStudent
extension ClassesEntity {

    @objc(addContainStudentObject:)
    @NSManaged public func addToContainStudent(_ value: StudentsEntity)

    @objc(removeContainStudentObject:)
    @NSManaged public func removeFromContainStudent(_ value: StudentsEntity)

    @objc(addContainStudent:)
    @NSManaged public func addToContainStudent(_ values: NSSet)

    @objc(removeContainStudent:)
    @NSManaged public func removeFromContainStudent(_ values: NSSet)

}
