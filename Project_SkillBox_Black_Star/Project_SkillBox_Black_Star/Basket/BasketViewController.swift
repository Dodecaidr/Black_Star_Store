//
//  BasketViewController.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 28.02.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {

    @IBOutlet weak var busketTabelView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var byButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contex = appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    

}

extension BasketViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as! BasketTableViewCell
        
        
        
        return cell

    }
    
    
}

