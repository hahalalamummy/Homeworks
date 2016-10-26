//
//  StudentsEntity+CoreDataProperties.swift
//  quan ly
//
//  Created by Admin on 10/26/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import CoreData

extension StudentsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudentsEntity> {
        return NSFetchRequest<StudentsEntity>(entityName: "StudentsEntity");
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var dateOfBirth: NSDate?
    @NSManaged public var picture: NSData?
    @NSManaged public var studyAt: NSSet?

}

// MARK: Generated accessors for studyAt
extension StudentsEntity {

    @objc(addStudyAtObject:)
    @NSManaged public func addToStudyAt(_ value: ClassesEntity)

    @objc(removeStudyAtObject:)
    @NSManaged public func removeFromStudyAt(_ value: ClassesEntity)

    @objc(addStudyAt:)
    @NSManaged public func addToStudyAt(_ values: NSSet)

    @objc(removeStudyAt:)
    @NSManaged public func removeFromStudyAt(_ values: NSSet)

}
