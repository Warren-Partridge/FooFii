//
//  FirstViewController.swift
//  FooFii
//
//  Created by Calvin Rose on 10/17/17.
//  Copyright © 2017 Calvin Rose. All rights reserved.
//

import UIKit
//importing Firebase
import Firebase

class LoginController: UIViewController {
    
    //textFields for First Name, Last Name, and Email
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    //button for Login
    @IBAction func buttonLogIn(_ sender: UIButton) {
        //do the registration operation here
        //let first_name = textFieldFirstName.text
        //let last_name = textFieldLastName.text
        //let email = textFieldEmail.text
        
        Auth.auth().signInAnonymously() { (user, error) in
            if error != nil {
                print(error)
                return
            }
            print("User logged in anonymously with uid: " + user!.uid)
            
        }
    }
    
    //button for Sign out
    @IBAction func signOut(_ sender: UIButton) {
        
        //@IBAction func signOut(_ sender: UIButton) {
        print("User logged out...")
        try!Auth.auth().signOut()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

