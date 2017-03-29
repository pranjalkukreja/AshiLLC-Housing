//
//  ViewController.swift
//  AshiLLC-Housing
//
//  Created by Pranjal Kukreja on 2/25/17.
//  Copyright © 2017 Pranjal Kukreja. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class ViewController: UIViewController {
    
    @IBAction func signInBtn(_ sender: Any) {
        
        if let email = emailField.text, let password = passwordField.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                
                if error == nil {
                    
                    print("Email user Authenticated with Firebase")
                    if let user = user {
                         let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                        
                    }

                    
                } else {
                    
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            
                            print("Unable to Authenticate with Firebase using Email")
                            
                        } else {
                            
                            print("Succesfully Authenticcated with Firebase using Email")
                            
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                
                                self.completeSignIn(id: user.uid, userData: userData)
                                
                            }

                        }
                        
                    })
                    
                }
                
            })
            
            
            
            
        }
        
        
        
        
    }
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    

    @IBAction func fbBtnTapped(_ sender: Any) {
        
       
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("JUser cancelled Facebook authentication")
            } else {
                print("Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Unable to authenticate with Firebase - \(error)")
            } else {
                print("Successfully authenticated with Firebase")
                
                if let user = user {
                
                     let userData = ["provider": credential.provider]
                    
                    self.completeSignIn(id: user.uid, userData: userData)
                
                }
                }
            
        })
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("ID found in Keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
            
        }
        
        
        
    }
    
    
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    func completeSignIn(id : String, userData: Dictionary <String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        
        let KeychainResult = KeychainWrapper.standard.set( id, forKey: KEY_UID)
        
        print("Data Saved to Keychain \(KeychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
        
        
    }
    
    


}

