//
//  JSONRequest.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 04/02/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import Foundation
import Alamofire

struct ItemCategory: Codable {
    var name: String?
    var sortOrder: String?
    var iconImage: String?
    var iconImageActive: String?
    var subcategories: [ItemSubcategory]?

    enum CodingKeys: String, CodingKey {
        case name, sortOrder, iconImage, iconImageActive, subcategories
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(sortOrder, forKey: .sortOrder)
        try container.encode(iconImage, forKey: .iconImage)
        try container.encode(iconImageActive, forKey: .iconImageActive)
        try container.encode(subcategories, forKey: .subcategories)
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try? container.decode(String.self, forKey: .name)
        sortOrder = try? container.decode(String.self, forKey: .sortOrder)
        iconImage = try? container.decode(String.self, forKey: .iconImage)
        iconImageActive = try? container.decode(String.self, forKey: .iconImageActive)
        subcategories = try? container.decode([ItemSubcategory].self, forKey: .subcategories)
    }
}

struct ItemSubcategory: Codable {
    var id: String?
    var iconImage: String?
    var sortOrder: String?
    var name: String?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case id, iconImage, sortOrder, name, type
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(sortOrder, forKey: .sortOrder)
        try container.encode(iconImage, forKey: .iconImage)
        try container.encode(type, forKey: .type)
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(String.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        sortOrder = try? container.decode(String.self, forKey: .sortOrder)
        iconImage = try? container.decode(String.self, forKey: .iconImage)
        type = try? container.decode(String.self, forKey: .type)
    }
}

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
