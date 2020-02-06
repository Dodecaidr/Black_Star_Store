//
//  CategoryTableViewController.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 06/02/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit
import Alamofire
//import AlamofireImage

class CategoryTableViewController: UITableViewController {
    
    var categorys: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        JsonRequest().loadCategory { list in
            self.categorys = list
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard categorys.count != 0 else {return 1}
        return categorys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categorys[0]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        
        cell.nameCategoryLabel.text = category.name
        cell.imageCategoryIV.image = downloadImage(http: category.iconImage)
        
        return cell
    }
    
    
    func downloadImage (http: String) -> UIImage {
        
        var imageReturn: UIImage = UIImage(named: "Test_Image")!
        
        guard let url = URL(string: http) else { return UIImage.init(named: "Test_Image")!}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data){
                imageReturn = image
            }
            
        }.resume()
            return imageReturn
    }
    
}
