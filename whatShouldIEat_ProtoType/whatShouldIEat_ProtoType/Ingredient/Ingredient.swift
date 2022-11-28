//
//  Ingredient.swift
//  whatShouldIEat_ProtoType
//
//  Created by Roen White on 2022/11/08.
//
struct Ingredient : Codable, Identifiable {
    var id: String
    var icon: String
    var category: String
    var ingredient: String
    var ishave: Bool
    var isFrozen: Bool
}
