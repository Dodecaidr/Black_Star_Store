//
//  SubCategoryTableViewController.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 09/02/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit
import SDWebImage

class SubCategoryTableViewController: UITableViewController {

    var subCategories: ItemCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.overrideUserInterfaceStyle = .light
        
        guard let _ = subCategories else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return subCategories?.subcategories?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryCell", for: indexPath) as! SubCategoryTableViewCell
        let subCategory = subCategories?.subcategories?[indexPath.row]
        
        cell.subCategoryLabel.text = subCategory?.name
        cell.subCategoryIV.sd_setImage(with: URL(string:"https://blackstarwear.ru/\(String( subCategory?.iconImage ?? "11"))"), completed: nil)
        cell.subCategoryIV.layer.masksToBounds = true
        cell.subCategoryIV.layer.cornerRadius = cell.subCategoryIV.frame.width / 2

        return cell
    }

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if segue.identifier == "SubCategoryOnProduct" {
                  guard let indexPath = tableView.indexPathForSelectedRow else { return }
                  if let newTaskVC = segue.destination as? ProductCollectionViewController {
                    let subCategory = Int(subCategories?.subcategories?[indexPath.row].id ?? "1")
                    newTaskVC.id = subCategory ?? 1
                  }
              }
          }
}
