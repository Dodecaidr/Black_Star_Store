//
//  ProductDescriptionViewController.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 16.02.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit

class ProductDescriptionViewController: UIViewController, UIScrollViewDelegate {
    
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var othersTabelView: UITableView!
    @IBOutlet weak var imageScrolView: UIScrollView!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var imageFrameView: UIView!
    
    var products: ItemProduct?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
         imageScrolView.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width , height:imageFrameView.frame.height)
        var countImage = 0
              imagePageControl.numberOfPages = products?.productImages.count ?? 0
              countImage = products?.productImages.count ?? 0
        
        for i in 0..<countImage {
         
         let imageView = UIImageView()
         imageView.contentMode = .scaleToFill
         imageView.sd_setImage(with: URL(string:"https://blackstarwear.ru/\(String(products?.productImages[i].imageURL ?? "sad"))"), completed: nil)
        
         
         let xPos = CGFloat(i) * self.view.bounds.size.width
         imageView.frame = CGRect(x: xPos, y: 0, width: view.frame.size.width, height: imageFrameView.frame.size.height)
         imageScrolView.contentSize.width = view.frame.size.width * CGFloat(i+1)
         imageScrolView.addSubview(imageView)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.overrideUserInterfaceStyle = .light
        
        othersTabelView.isHidden = true
      
        
        var price = ""
        let priceSepar = products?.price?.split(separator: ".")
        price = price + (priceSepar?[0] ?? "цена не указана")
        
      
        nameProductLabel.text = products?.englishName
        priceLabel.text = price + " ₽"
        descriptionTextView.text = products?.description?.htmlToString
        
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = imageScrolView.contentOffset.x/imageScrolView.frame.width
        
        imagePageControl.currentPage = Int(page)
    }
    @IBAction func cancelButtonTabelView(_ sender: Any) {
        othersTabelView.isHidden = true
    }
    
    @IBAction func pressAddButton(_ sender: Any) {
        
        othersTabelView.isHidden = false
        
    }
}


extension ProductDescriptionViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.offers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        
        cell.colorLabel.text = products?.colorName
        cell.sizeLabel.text = products?.offers[indexPath.row].size
        
        return cell
    }
    
    
}
