//
//  ProductViewController.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 16/02/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var id: Int?
    var products: [ItemProduct] = []
    let qwe = ["2332","2323","321314"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        JsonRequestProduct().loadCategory(id: id ?? 0) { list in
//                  self.products = list
//                  DispatchQueue.main.async {
//                      self.collectionView.reloadData()
//                  }
//
//              }
    }
    
}

extension ProductViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return qwe.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        
        cell.productIV.image = UIImage( contentsOfFile: "Test_Image")
        cell.productDescriptionLabel.text = "213"
        cell.productPriceLabel.text = "213"
        
        return cell
    }
    
    
}
