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
	
	let recipeManager = RecipeNetworkModel()
	
	let ingredientCategoryList: [String] = [
		"채소/과일",
		"버섯류",
		"육류/달걀",
		"콩류/견과류/두부류",
		"유제품",
		"김치",
		"가루류",
		"조미료/양념류/오일류",
		"민물/해산물",
		"음료류",
		"면류",
		"곡물/가공류",
		"기타"
	]
    
    let ingredientSaveWhereList : [Ingredient.SaveWhere] = [.refrigeration, .frozen, .roomTemperature]

	private func initDictionary() {
		for eachIngredients in ingredientData {
			let key = eachIngredients.ingredient
			
			if ingredientsDictionary[key] == nil {
				ingredientsDictionary.updateValue([eachIngredients],
												  forKey: key)
			}
		}
	}
	
	public func updateDictionary(eachIngredients: Ingredient) {
		let key = eachIngredients.ingredient
		if ingredientsDictionary[key] == nil {
			ingredientsDictionary.updateValue([eachIngredients], forKey: key)
		} else {
			ingredientsDictionary[key]?.append(eachIngredients)
		}
        print("---updateDictionary---")
        print(ingredientsDictionary)
        print("-------")
	}
    
    // 전달받은 재료의 id와 같은 재료를 배열에서 찾아서 인덱스를 반환하는 함수
    func getIngredientIndex(ingredient : Ingredient) -> Int {
        if let ingredients = ingredientsDictionary[ingredient.ingredient] {
            if !ingredients.isEmpty {
                return ingredients.enumerated().filter{$0.element.id == ingredient.id}.first!.offset
            }
        }
        return 0
    }
    
    // 현재 보유중인 모든 재료를 1차원으로 담아서 반환하는 함수
    func getMyIngredients() -> [Ingredient] {
        var ingredients : [Ingredient] = []
        for name in ingredientsDictionary {
            for ingredient in name.value {
                ingredients.append(ingredient)
            }
        }
        return ingredients
    }
    
    // 레시피에 있는 필요 재료 리스트를 내 보유 재료와 비교하여 모두 가지고 있는지 여부
    func isHaveAllNeedIngredients(needIngredientsName : [String]) -> Bool {
        let myIngredients = ["검은콩","메밀면","오이","방울토마토","땅콩","잣","참깨"] // 검은메밀면 조리가능에 뜨는지 확인하는 더미 데이터
//        let myIngredients = getMyIngredients().map{$0.ingredient} // 실제 코드
        return needIngredientsName.filter{name in
            return !myIngredients.contains(name)
        }.isEmpty
    }
    
}

