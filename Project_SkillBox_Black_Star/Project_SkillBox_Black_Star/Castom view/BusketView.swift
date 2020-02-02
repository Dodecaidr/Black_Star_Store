//
//  BusketView.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 02/02/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit

class BusketView: UIView {
    
    @IBOutlet weak var BusketImage: UIImageView!
    @IBOutlet weak var ButtonPrice: UIButton!
    
    var quantity: String {
        get {
            return ButtonPrice.titleLabel?.text! ?? ""
        }
        set(quantityText) {
            ButtonPrice.titleLabel?.text = quantityText
        }
    }
    
    var view: UIView!
    var nibName: String = "BusketView"
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func loadFromNib () -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view =  nib.instantiate(withOwner: self, options: nil).first as! UIView
        
//        let picker = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)
        // https://www.youtube.com/watch?v=9Xvsik6BvKA
//        let view = picker![0] as! UIView
        
        return view
    }
    
    func setup () {
        view = loadFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        addSubview(view)
    }
    
    
}
