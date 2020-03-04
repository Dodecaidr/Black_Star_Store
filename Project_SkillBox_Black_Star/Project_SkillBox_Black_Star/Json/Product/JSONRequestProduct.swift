//
//  JSONRequestProduct.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 15/02/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import Foundation
import Alamofire

class JsonRequestProduct {
    
    func loadCategory(id: Int, callback: @escaping ([ItemProduct])->()){
        Alamofire.request("http://blackstarshop.ru/index.php?route=api/v1/products&cat_id=\(id)", method: .get)
            .responseJSON { response in
                if let objects = response.result.value, let jsonDict = objects as? NSDictionary {
                if let values = jsonDict.allValues as? [[String: Any]] {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: values, options: .fragmentsAllowed)
                        let categories = try JSONDecoder().decode([ItemProduct].self, from: data)
                        callback(categories)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
