//
//  dataService.swift
//  AshiLLC-Housing
//
//  Created by Pranjal Kukreja on 3/28/17.
//  Copyright © 2017 Pranjal Kukreja. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()



class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USER = DB_BASE.child("user")
    
    
    var REF_BASE: FIRDatabaseReference{
        
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference{
        
        return _REF_POSTS
    }
    
    var REF_USER: FIRDatabaseReference{
        
        return _REF_USER
    }
    
    
    func createFirebaseDBUser(uid:String, userData: Dictionary <String, String>){
        
        REF_USER.child(uid).updateChildValues(userData)
        
    }
    
    
}
