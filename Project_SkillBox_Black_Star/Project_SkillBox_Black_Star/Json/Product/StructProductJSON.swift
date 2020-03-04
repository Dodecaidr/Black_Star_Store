//
//  StructProductJSON.swift
//  Project_SkillBox_Black_Star
//
//  Created by Илья Лобков on 15/02/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import Foundation

struct ItemProduct: Codable {
    var name: String?
    var englishName: String?
    var sortOrder: String?
    var article: String?
    var description: String?
    var colorName: String?
    var colorImageURL: String?
    var mainImage: String?
    var productImages: [ItemImage]
    var offers: [ItemParam]
    var price: String?
    var tag: String?
}

struct ItemImage: Codable {
    var imageURL: String?
    var sortOrder: String?
}

struct ItemParam: Codable {
    var size: String?
    var productOfferID: String?
}
