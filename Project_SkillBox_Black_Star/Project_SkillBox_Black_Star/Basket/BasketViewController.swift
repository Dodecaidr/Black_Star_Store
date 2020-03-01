//
//  BasketViewController.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 28.02.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit
import CoreData

class BasketViewController: UIViewController {
    
    @IBOutlet weak var busketTabelView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var byButton: UIButton!
    @IBOutlet weak var zeroBusketLabel: UILabel!
    
    var pruducts: [Product] = []
    var priceSum = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zeroBusketLabel.isHidden = true
        zeroBusketLabel.alpha = 0
        
        byButton.layer.masksToBounds = true
        byButton.layer.cornerRadius = 10
    }
    
    func updateModel(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contex = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            pruducts = try contex.fetch(fetchRequest)
            if pruducts.count != 0 {
                for i in 0...(pruducts.count - 1) {
                    let product = pruducts[i]
                    let priceSepar = product.price!.split(separator: ".")
                    
                    priceSum = priceSum + (Int(priceSepar[0] ) ?? 0)
                    totalPriceLabel.text = String(priceSum)
                }
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func buyButtonAction(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contex = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        if let object = try? contex.fetch(fetchRequest) {
            for object in object {
                contex.delete(object)
            }
        }
        do {
            try  contex.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        self.viewDidLoad()
        DispatchQueue.main.async {
            self.busketTabelView.reloadData()
        }
        
        UIView.animate(withDuration: 2, animations: {
            self.zeroBusketLabel.alpha = 1
            self.zeroBusketLabel.isHidden = false
            self.zeroBusketLabel.text = "Add product to basket"
        })
    }
}

extension BasketViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  pruducts.count == 0 {
            zeroBusketLabel.isHidden = false
            zeroBusketLabel.alpha = 1
            zeroBusketLabel.text = "Add product to basket"
            totalPriceLabel.text = "0 ₽"
        } else {
            zeroBusketLabel.isHidden = true
            zeroBusketLabel.alpha = 0
        }
        print(pruducts.count)
        return pruducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as! BasketTableViewCell
        print(pruducts.count)
        if  pruducts.count != 0 {
            let product = pruducts[indexPath.row]
            var price = ""
            let priceSepar = product.price?.split(separator: ".")
            price = price + (priceSepar?[0] ?? "")
            priceSum = priceSum + (Int(price) ?? 0)
            
            cell.basketColorLabel.text = "Color: " + (product.collor ?? "non Color")
            cell.basketImage.sd_setImage(with:URL(string:"https://blackstarwear.ru/\(String(product.image ?? "asd"))"), completed: nil)
            cell.basketNameLabel.text = product.name
            cell.basketPriceLabel.text = price + " ₽"
            cell.basketSizeLabel.text = "Size: " + (product.size ?? "non Size")
        }
        else {
            zeroBusketLabel.isHidden = false
            zeroBusketLabel.alpha = 1
        }
        return cell
    }
    
    // Mark: - удаление спомощью нового метода iOS13
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let contex = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
            let taskDelete = self.pruducts[indexPath.row]
            
            contex.delete(taskDelete)
            
            do {
                try contex.save()
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            self.updateModel()
            
            DispatchQueue.main.async {
                tableView.reloadData()
            }
            
        }
        return UISwipeActionsConfiguration(actions: [actionDelete])
    }
    
}

