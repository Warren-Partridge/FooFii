//
//  SNAPDetailViewController.swift
//  FooFii
//
//  Created by Calvin Rose on 5/4/18.
//  Copyright © 2018 Calvin Rose. All rights reserved.
//

import UIKit

class SNAPDetailViewController: UIViewController {
    
    // Set by parent view controller before viewDidLoad
    var snap: Snap? = nil
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = snap?.name
        addressView.text = "\(snap!.address)\n\(snap!.cityName), \(snap!.state) \(snap!.zip)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
