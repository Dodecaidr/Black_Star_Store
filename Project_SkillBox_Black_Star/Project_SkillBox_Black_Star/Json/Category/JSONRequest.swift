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
    
    func loadCategory(callback: @escaping ([ItemCategory])->()){
        Alamofire.request("https://blackstarshop.ru/index.php?route=api/v1/categories", method: .get)
            .responseJSON { response in
                if let objects = response.result.value, let jsonDict = objects as? NSDictionary {
                if let values = jsonDict.allValues as? [[String: Any]] {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: values, options: .fragmentsAllowed)
                        let categories = try JSONDecoder().decode([ItemCategory].self, from: data)
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
