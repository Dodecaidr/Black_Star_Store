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

    var subCategories: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return subCategories?.subcategories.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryCell", for: indexPath) as! SubCategoryTableViewCell
        let subCategory = subCategories?.subcategories[indexPath.row]
        
        cell.subCategoryLabel.text = subCategory?.name
        cell.subCategoryIV.sd_setImage(with: URL(string:"https://blackstarwear.ru/\(String(describing: subCategory?.iconImage))"), completed: nil)
        

        return cell
    }

   

}
