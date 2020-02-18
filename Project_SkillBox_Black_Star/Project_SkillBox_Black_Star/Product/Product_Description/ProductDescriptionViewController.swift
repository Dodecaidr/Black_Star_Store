//
//  ProductDescriptionViewController.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 16.02.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit

class ProductDescriptionViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var products: ItemProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        nameProductLabel.text = products?.englishName
        priceLabel.text = products?.price
        descriptionLabel.text = products?.description?.htmlToString
        productImageView.sd_setImage(with: URL(string:"https://blackstarwear.ru/\(String(products?.productImages[0].imageURL ?? "sad"))"), completed: nil)
        
    }

}
