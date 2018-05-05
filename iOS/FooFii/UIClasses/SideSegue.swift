//
//  SideSegue.swift
//  FooFii
//
//  Copyright © 2018 Global App Initiative. All rights reserved.
//

import Foundation
import UIKit

// A custom segue to be used for sliding the between VCs from left to right.
// Used in the LoginController and the QuestionaireController to make transitions
// prettier.
class SideSegue: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        })
    }
}
