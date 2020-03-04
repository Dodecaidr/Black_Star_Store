//
//  StartViewController.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 30/01/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var openButtom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openButtom.layer.masksToBounds = true
        openButtom.layer.cornerRadius = openButtom.bounds.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
              self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.setNavigationBarHidden(false, animated: true)
         super.viewWillDisappear(animated)
    }
    
}
