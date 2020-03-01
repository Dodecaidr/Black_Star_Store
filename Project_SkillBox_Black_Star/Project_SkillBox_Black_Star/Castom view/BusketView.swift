//
//  BusketView.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 02/02/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit
import CoreData

class BusketView: UIView {
    
    @IBOutlet weak var busketImage: UIImageView!
    @IBOutlet weak var buttonPrice: UIButton!{
        didSet {
                   buttonPrice.layer.masksToBounds = true
            buttonPrice?.layer.cornerRadius = (buttonPrice?.frame.height)! / 2
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let contex = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
            var pruducts: [Product] = []
            do {
                pruducts = try contex.fetch(fetchRequest)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            buttonPrice.setTitle(String(pruducts.count), for: .normal)
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
    
    @IBAction func openBasketButton(_ sender: Any) {
    }
}
