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

    var posts = [Post]()
    
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
        
       
        
        
        return posts.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            
            cell.configureCell(post: post)
            
            return cell
        } else {
            return PostCell()
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        
        tableView.dataSource = self
        
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }

  

  

}
