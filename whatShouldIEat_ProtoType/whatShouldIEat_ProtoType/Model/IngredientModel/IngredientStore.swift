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
    
    init (ingredients: [Ingredient] = []) {
        self.ingredients = ingredients
    }
}
