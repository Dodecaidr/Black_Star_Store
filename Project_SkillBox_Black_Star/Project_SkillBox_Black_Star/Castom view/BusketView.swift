//
//  BusketView.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 02/02/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit

class BusketView: UIView {
    
    @IBOutlet weak var busketImage: UIImageView!
    @IBOutlet weak var buttonPrice: UIButton!{
        didSet {
                   buttonPrice.layer.masksToBounds = true
            buttonPrice?.layer.cornerRadius = (buttonPrice?.frame.height)! / 2
               }
    }
    
    
    var quantity: String {
        get {
            return buttonPrice.titleLabel?.text! ?? ""
        }
        set(quantityText) {
            buttonPrice.titleLabel?.text = quantityText
        }
    }
    
    var contentView: UIView?
    var nibName: String = "BusketView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    private func loadViewFromNib() -> UIView? {
        let nibView = UINib(nibName: nibName, bundle: nil)
        return nibView.instantiate(withOwner: self, options: nil).first as? UIView
        
    }
    
}
