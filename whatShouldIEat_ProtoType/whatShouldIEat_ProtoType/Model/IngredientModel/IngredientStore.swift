//
//  IngredientStore.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/09.
//

import SwiftUI

final class IngredientStore: ObservableObject {
    @Published var ingredients: [Ingredient] = ingredientData
	@Published var ingredientsDictionary: [String: [Ingredient]] = [:]
	
	init() {
		initDictionary()
	}
	
	private func initDictionary() {
		for eachIngredients in ingredientData {
			let key = eachIngredients.ingredient
			
			if ingredientsDictionary[key] == nil {
				ingredientsDictionary.updateValue([eachIngredients], forKey: key)
			}
		}
		dump(ingredientsDictionary)
	}
	
	public func updateDictionary(eachIngredients: Ingredient) {
		let key = eachIngredients.ingredient
		ingredientsDictionary[key]?.append(eachIngredients)
	}
}
