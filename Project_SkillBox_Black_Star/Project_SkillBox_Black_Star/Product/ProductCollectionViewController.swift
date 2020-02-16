//
//  ProductCollectionViewController.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 15/02/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "ProductCell"

class ProductCollectionViewController: UICollectionViewController {
    
    var id: Int?
    var products: [ItemProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        JsonRequestProduct().loadCategory(id: id ?? 0) { list in
            self.products = list
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.size.width / 1, height: UIScreen.main.bounds.size.height / 1)
//    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard products.count != 0 else {
            return 1
        }
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        
        
        if products.count == 0 {
            cell.productIV.image = UIImage( contentsOfFile: "Test_Image")
            cell.productPriceLabel.text = "!@3"
            cell.productDescriptionLabel.text = "Здесь будет описание товара"
        }
        else {
            let product = products[indexPath.row]
            let image = product.productImages[0].imageURL
            var price = ""
            let priceSepar = products[indexPath.row].price!.split(separator: ".")
            price = price + priceSepar[0]
            cell.productIV.sd_setImage(with: URL(string:"https://blackstarwear.ru/\(image!)"), completed: nil)
            cell.productPriceLabel.text = price
            cell.productDescriptionLabel.text = product.description!

        }
        return cell
    }
    
}
