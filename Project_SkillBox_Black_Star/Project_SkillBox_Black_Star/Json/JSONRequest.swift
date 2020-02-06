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
            if let objects = response.result.value {
                do {
                    let requestJSon = try JSONDecoder().decode(RequestJS.self, from: objects as! Data)
                    var listCategory: [Category] = []
                    requestJSon.category.forEach { category in
                        if let catrgory = category {
                            listCategory.append(catrgory)
                        }
                    }
                    callback(listCategory)
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
}
