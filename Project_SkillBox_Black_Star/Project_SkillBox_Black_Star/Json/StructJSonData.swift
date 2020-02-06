//
//  StructJSonData.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 05.02.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import Foundation


struct RequestJS:Decodable {
    var category: [Category?]
}

struct Category: Decodable {
    var name: String
    var sortOrder: String
    var image: String
    var iconImage: String
    var iconImageActive: String
    var subcategories: [Subcategories]
}

struct Subcategories: Decodable {
    var id: String
    var iconImage: String
    var sortOrder: String
    var name: String
    var type: String
}
