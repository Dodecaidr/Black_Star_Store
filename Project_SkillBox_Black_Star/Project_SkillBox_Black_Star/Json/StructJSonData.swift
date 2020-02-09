//
//  StructJSonData.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 05.02.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import Foundation

//
//struct RequestJS:Decodable {
//    var category: [Category?]
//}


class Category {
    var name: String
    var sortOrder: Int
    var image: String
    var iconImage: String
    var iconImageActive: String
    var subcategories: [Subcategories]
    
    init?(data: NSDictionary){
        guard let name = data["name"] as? String,
        let sortOrder = data["sortOrder"] as? String,
        let image = data["image"] as? String,
        let iconImage = data["iconImage"] as? String,
        let iconImageActive = data["iconImageActive"] as? String,
            let subcategories = data["Subcategories"] as? [Subcategories]
            else { return nil }
        self.name = name
        self.sortOrder = Int(sortOrder) ?? 0
        self.image = image
        self.iconImage = iconImage
        self.iconImageActive = iconImageActive
        self.subcategories = subcategories
    }
}

class Subcategories {
    var id: Int
    var iconImage: String
    var sortOrder: String
    var name: String
    var type: String
    
    init?(data: NSDictionary) {
        guard let id = data["id"] as? Int,
        let iconImage = data["iconImage"] as? String,
        let sortOrder = data["String"] as? String,
        let name = data["String"] as? String,
            let type = data["type"] as? String else {return nil}
        
        self.id = Int(id)
        self.iconImage = iconImage
        self.sortOrder = sortOrder
        self.name = name
        self.type = type
        
    }
}

//class CategoryLoaded {
//    let name: String = ""
//    var sortOrder: String
//    var image: String
//    var iconImage: String
//    var iconImageActive: String
//    var subcategories: [Subcategories]
//}
