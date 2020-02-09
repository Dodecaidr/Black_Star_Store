//
//  JSONRequest.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 04/02/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import Foundation
import Alamofire

class JsonRequest {
    
    func loadCategory(callback: @escaping ([Category])->()){
        Alamofire.request("http://blackstarshop.ru/index.php?route=api/v1/categories", method: .get).responseJSON { response in
            if let objects = response.result.value,
                let jsonDict = objects as? NSDictionary{
                var categories: [Category] = []
                var subCategories: [Subcategories] = []
                for (_,data) in jsonDict where data is NSDictionary{
                    if let category = Category(data: data as! NSDictionary) {
                        for (_,data) in jsonDict where data is NSDictionary{
                        if let subCategory = Subcategories(data: data as! NSDictionary){
                            subCategories.append(subCategory)
                            }}
                        categories.append(category)}
                }
                print(subCategories.count)
                print(categories)
                print(categories.count)
                DispatchQueue.main.async {
                    callback(categories)
                }
            }
        }
    }
}
