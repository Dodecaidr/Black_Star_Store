//
//  CategoryTableViewController.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 06/02/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class CategoryTableViewController: UITableViewController {
    @IBOutlet weak var busketCategiryItemBar: UIBarButtonItem!
    
    var categories: [ItemCategory] = []
    var image: UIImageView = UIImageView(image: UIImage(contentsOfFile: "Test_Image"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    /// Настройка NAvigation Controller
    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        JsonRequest().loadCategory { list in
            self.categories = list
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - Настройка таблицы
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard
            categories.count != 0 else {
                return 1
        }
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        
        
        if categories.isEmpty {
            tableView.allowsSelection = false // отключает нажатие на ячейку
            cell.imageCategoryIV.image = UIImage(contentsOfFile: "Test_Image")
            cell.nameCategoryLabel.text = "Loading..."
        }
        else {
            tableView.allowsSelection = true
            let category = categories[indexPath.row]
            var iconImage = category.iconImage
            if category.iconImage == "" {
               iconImage = "image/catalog/style/modile/acc_cat.png"
            }
            cell.nameCategoryLabel.text = category.name ?? ""
            cell.imageCategoryIV?.sd_setImage(with: URL(string:"https://blackstarwear.ru/\(iconImage ?? "image/catalog/im2017/3.png")"), completed: nil )
            
        }
        return cell
    }
    
    // MARK: - Передача данных на SubCtegoty
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategorySub" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            if let newTaskVC = segue.destination as? SubCategoryTableViewController {
                let subCategory = categories[indexPath.row]
                newTaskVC.subCategories = subCategory
            }
        }
    }
}
