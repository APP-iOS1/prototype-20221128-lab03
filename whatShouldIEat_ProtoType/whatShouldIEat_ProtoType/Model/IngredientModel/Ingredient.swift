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

// MARK: - IngredientModel
struct IngredientModel: Codable {
    let cookrcp01: Cookrcp01

    enum CodingKeys: String, CodingKey {
        case cookrcp01 = "COOKRCP01"
    }
}

// MARK: - Cookrcp01
struct Cookrcp01: Codable {
    let totalCount: String
    let row: [[String:String]]
    let result: Result

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case row
        case result = "RESULT"
    }
}

struct RowModel: Codable {
    let ingredients: String
    
    enum CodingKeys: String, CodingKey {
        case ingredients = "RCP_PARTS_DTLS"
    }
}

// MARK: - Result
struct Result: Codable {
    let msg, code: String

    enum CodingKeys: String, CodingKey {
        case msg = "MSG"
        case code = "CODE"
    }
}

