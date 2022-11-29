//
//  RecipeStore.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/09.
//

import Combine

class RecipeStore: ObservableObject {
    @Published var recipes: [Recipe]
    
    init (recipes: [Recipe] = []) {
        self.recipes = recipes
    }
}

