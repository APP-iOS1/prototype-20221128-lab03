//
//  Recipe.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/09.
//

import Foundation

struct Recipe : Codable, Identifiable {
    var id: String
    var dish: String
    var description: String
    var ingredients: [String]
    var recipe: [String]
    var isBookmark: Bool
    var imageName: String
}
