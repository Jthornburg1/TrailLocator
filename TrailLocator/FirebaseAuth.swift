//
//  FirebaseAuth.swift
//  TrailLocator
//
//  Created by jonathan thornburg on 9/17/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseAuth {
    
    func registerUser(_ password: String, email: String, completion: @escaping (_ success: Bool, _ message: String, _ id: String?) -> Void) {
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print("Firebase login error: \(error!.localizedDescription)")
                DispatchQueue.main.async(execute: {() -> Void in
                    completion(false, "firebaseError", nil)
                })
            } else {
                DispatchQueue.main.async(execute: {() -> Void in
                    let id = String(user!.uid)
                    completion(true, "registerSuccess", id)
                })
            }
        })
    }
    
    func logoutOfFirebase() {
        do {
            try FIRAuth.auth()!.signOut()
        } catch {
            print("error: FIRAuthErrorCodeKeychainError")
        }
    }
}
