//
//  IngredientStore.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/09.
//

import Combine

class IngredientStore: ObservableObject {
    @Published var ingredients : [Ingredient]
    @Published var test : Bool = false
    @Published var ingredientSamples : IngredientModel
    
    init (ingredients: [Ingredient] = [], ingredientSamples: IngredientModel = IngredientModel(cookrcp01: Cookrcp01(totalCount: "", row: [["a":"b"]], result: Result(msg: "", code: "")))) {
        self.ingredients = ingredients
        self.ingredientSamples = ingredientSamples
    }
    
    func doSomething() {
        var ssub: Set<String> = Set<String>()
        let temp = self.ingredientSamples.cookrcp01.row.map {
            $0["RCP_PARTS_DTLS"]!
        }
        temp.forEach { item in
            item.split(separator: ",").forEach { sub in
                let subsub = String(sub)
                var subsubsub = subsub.contains("(") ? String(subsub.split(separator: "(").first!)
                : subsub.contains(" ") ? String(subsub.split(separator: " ").first!) : subsub
//                print("\(subsubsub)")
                subsubsub = subsubsub.replacingOccurrences(of: "재료", with: "")
                    .replacingOccurrences(of: "다진", with: "")
                    .replacingOccurrences(of: "\n", with: "")
                let regex = try! Regex("[0-9]") // Thanks for sj.
                if !subsubsub.contains(regex) {
                    ssub.insert(subsubsub.trimmingCharacters(in: .whitespaces))
                }
            }
        }
        // for 끝
        ssub.sorted().forEach { item in
            print("\(item)")
        }
    }
    
}

