//
//  ProductDescriptionViewController.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 16.02.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit
import CoreData

class ProductDescriptionViewController: UIViewController, UIScrollViewDelegate {
    
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var othersTabelView: UITableView!
    @IBOutlet weak var imageScrolView: UIScrollView!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var imageFrameView: UIView!
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var products: ItemProduct?
    var productCorData: [Product] = []
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageScrolView.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width , height:imageFrameView.frame.height)
        var countImage = 0
        imagePageControl.numberOfPages = products?.productImages.count ?? 0
        countImage = products?.productImages.count ?? 0
        
        for i in 0..<countImage {
            
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.sd_setImage(with: URL(string:"https://blackstarwear.ru/\(String(products?.productImages[i].imageURL ?? "sad"))"), completed: nil)
            
            
            let xPos = CGFloat(i) * self.view.bounds.size.width
            imageView.frame = CGRect(x: xPos, y: 0, width: view.frame.size.width, height: imageFrameView.frame.size.height)
            imageScrolView.contentSize.width = view.frame.size.width * CGFloat(i+1)
            imageScrolView.addSubview(imageView)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveLabel.layer.masksToBounds = true
        saveLabel.layer.cornerRadius = 10
        view.overrideUserInterfaceStyle = .light
        addButton.layer.masksToBounds = true
        addButton.layer.cornerRadius = 10
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var describProduct = ""
        describProduct = (products?.colorName ?? "none") + " " + (products?.offers[indexPath.row].size ?? "none")
        
        let ac = UIAlertController(title: "Do you want to add this item?", message: describProduct, preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addbutton = UIAlertAction(title: "add", style: .default) {
            _ in
            self.saveTask(collorProduct: self.products!.colorName!, imageProduct: self.products!.mainImage!, nameProduct: self.products!.name!, piceProduct: self.products!.price!, sizeProduct: self.products!.offers[indexPath.row].size!)
            
            self.saveLabel.isHidden = false
            self.saveLabel.text = "Item added to cart"
            self.saveLabel.alpha = 1
            
            UIView.animate(withDuration: 3, animations: {
                self.saveLabel.alpha = 0
            }, completion: { _ in
                self.saveLabel.isHidden = true
            })
        }
        
        ac.addAction(cancelButton)
        ac.addAction(addbutton)
        present(ac, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func saveTask(collorProduct collor: String, imageProduct image: String, nameProduct name: String, piceProduct price: String, sizeProduct size: String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Product", in: context) else { return }
        
        let taskObject = Product(entity: entity, insertInto: context)
        
        taskObject.collor = collor
        taskObject.image = image
        taskObject.name = name
        taskObject.price = price
        taskObject.size = size
        
        do {
            try context.save()
            
        } catch let error as NSError {
            print(error.localizedDescription)
            self.saveLabel.isHidden = false
            self.saveLabel.text = "Failed to add product to cart"
            self.saveLabel.alpha = 1
            
            UIView.animate(withDuration: 4, animations: {
                self.saveLabel.alpha = 0
            }, completion: { _ in
                self.saveLabel.isHidden = true
            })
        }
    }
}
