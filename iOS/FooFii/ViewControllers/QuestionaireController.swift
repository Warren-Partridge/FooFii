//
//  Questionaire.swift
//  FooFii
//
//  Copyright © 2018 Global App Initiative. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class QuestionaireController: UIViewController {
    var ref: DatabaseReference!
    
    @IBOutlet weak var answer1: UITextField!
    @IBOutlet weak var answer2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        ref = Database.database().reference()
    }
    
    @IBAction func Post(_ sender: UIButton) {
        ref?.child("answer1").childByAutoId().setValue(answer1.text)
        ref?.child("answer2").childByAutoId().setValue(answer2.text)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
