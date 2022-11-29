//
//  IngredientData.swift
//  whatShouldIEat_ProtoType
//
//  Created by Roen White on 2022/11/08.
//

import SwiftUI

// FIXME: 감자감자가 가능하도록 isHave 키 변경해야 함
var ingredientData: [Ingredient] = loadJson("ingredientData.json")

class IngredientFetcher {
    
    func fecthData() async throws -> IngredientModel {
        print("fetching data...")
        guard let url = URL(string: "http://openapi.foodsafetykorea.go.kr/api/6eb420202d8b439192d8/COOKRCP01/json/2/50") else {
            print("URL ERROR")
            return IngredientModel(cookrcp01: Cookrcp01(totalCount: "", row: [["a":"b"]], result: Result(msg: "", code: "")))
        }
        let data = try await URLSession.shared.data(from: url).0
        print(data)
        print("fecthed data.")
        
//        let stringData = String(data: data, encoding: .utf8)
//        print(stringData)
        let decodedData = try JSONDecoder().decode(IngredientModel.self, from: data)
        return decodedData
    }
    
}
