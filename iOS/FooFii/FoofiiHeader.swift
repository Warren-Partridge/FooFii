//
//  FoofiiView.swift
//  FooFii
//
//  Created by William Munoz on 3/25/18.
//  Copyright © 2018 Calvin Rose. All rights reserved.
//

import UIKit


class FoofiiHeader: UIView {
    
    var content: UIView!
    
    
    override init(frame: CGRect) {//for using CustomView in code
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {// for using CustomView in IB
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit(){
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "header", bundle: bundle)
        content = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.addSubview(content)
        
//        Bundle.main.loadNibNamed("FoofiiHeader", owner: self, options: nil)
//        addSubview(content)
//        content.frame = self.bounds
//        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
}




