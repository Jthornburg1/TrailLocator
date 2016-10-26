//
//  SaveAndFetch.swift
//  TrailLocator
//
//  Created by Jon Thornburg on 9/12/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import CoreData

struct SaveAndFetch {
    
    let stack = Stack()
    
    func getContext() -> NSManagedObjectContext {
        if #available(iOS 10.0, *) {
            return stack.persistentContainer.viewContext
        } else {
            return NSManagedObjectContext()
        }
    }
    
    func storePerson(age: Int, name: String, isStudent: Bool) {
        //Make managedObjectContext
        let context = getContext()
        //Instantiate entity
        let entity = NSEntityDescription.entity(forEntityName: "PersonEntity", in: context)
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        //Set values for entity
        transc.setValue(age, forKey: "age")
        transc.setValue(name, forKey: "name")
        transc.setValue(isStudent, forKey: "isStudent")
    }
    
    
}
