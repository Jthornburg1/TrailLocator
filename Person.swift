//
//  Person.swift
//  
//
//  Created by Jon Thornburg on 9/12/16.
//
//

import Foundation
import CoreData

@objc(Person)
class Person: NSManagedObject {

    @NSManaged var name: String?
    @NSManaged var age: NSNumber?
    @NSManaged var isStudent: NSNumber?

}
