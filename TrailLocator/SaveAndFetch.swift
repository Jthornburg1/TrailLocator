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
    
    func saveOnePerson(_ name: String, age: Int, isStudent: Bool) {
        
        let entDesc = NSEntityDescription.entity(forEntityName: "PersonEntity", in: stack.managedObjectContext)
        let person = NSManagedObject(entity: entDesc!, insertInto: stack.managedObjectContext)
        
        person.setValue(name, forKey: "name")
        person.setValue(age, forKey: "age")
        person.setValue(isStudent, forKey: "isStudent")
        
        do {
            try stack.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    func fetchPeople() -> [Person]? {
        /*let fetchRequest = NSFetchRequest()
        let entityDesc = NSEntityDescription.entity(forEntityName: "PersonEntity", in: stack.managedObjectContext)
        fetchRequest.entity = entityDesc
        
        do {
            let result = try stack.managedObjectContext.fetch(fetchRequest) as! [Person]
            for p in result {
                print(p.name!)
                print(p.age!)
                print("Is this person a student?: \(p.isStudent!)")
            }
            return result
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }*/
        return nil
    }
}
