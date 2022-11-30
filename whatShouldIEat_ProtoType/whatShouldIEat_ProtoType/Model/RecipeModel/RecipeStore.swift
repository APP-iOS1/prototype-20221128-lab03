//
//  RecipeStore.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/09.
//

import Combine

class RecipeStore: ObservableObject {
    @Published var recipes: [Recipe]
    @Published var recipes2 : [EachRecipeDetail]
    
    init (recipes: [Recipe] = [], recipes2 : [EachRecipeDetail] = []) {
        self.recipes = recipes
        self.recipes2 = recipes2
    }
}

