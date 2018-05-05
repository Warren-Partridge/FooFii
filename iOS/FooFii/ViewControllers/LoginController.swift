//
//  FirstViewController.swift
//  FooFii
//
//  Copyright © 2018 Global App Initiative. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    //textFields for First Name, Last Name, and Email
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    
    //button for Login
    @IBAction func buttonLogIn(_ sender: UIButton) {

    }
    
    //button for Sign out
    @IBAction func signOut(_ sender: UIButton) {
        
        //@IBAction func signOut(_ sender: UIButton) {
        print("User logged out...")
        try!Auth.auth().signOut()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

