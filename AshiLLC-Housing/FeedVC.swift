//
//  FeedVC.swift
//  AshiLLC-Housing
//
//  Created by Pranjal Kukreja on 3/14/17.
//  Copyright © 2017 Pranjal Kukreja. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func SignOut(_ sender: Any) {
        
        
        let KeychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        
        print("ID removed from Keychain \(KeychainResult)")
        
        try! FIRAuth.auth()?.signOut()
        
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        
        tableView.dataSource = self
        
        
    }

  

  

}
