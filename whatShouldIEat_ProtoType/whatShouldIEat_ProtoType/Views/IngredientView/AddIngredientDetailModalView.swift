//
//  AddIngredientDetailModalView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 이승준 on 2022/11/30.
//

import SwiftUI

struct AddIngredientDetailModalView: View {
	@EnvironmentObject var ingredientManager: IngredientStore
	
	@Binding var isModalPresented: Bool
	@Binding var updatedNewIngredient: Bool
	@Binding var newIngredientArr: [NewIngredient]
	
	/// 각 셀에서 새로 만들어진 재료들을 배열로 관리, 추가하기 버튼으로 일괄 추가
	@State private var newUsersIngredientPicks = [UsersNewIngredient]()
	
	var body: some View {
		let ingredientCategoryList = ingredientManager.ingredientCategoryList
        let ingredientSaveWhereList = ingredientManager.ingredientSaveWhereList
		
		if !newIngredientArr.isEmpty {
			ScrollView {
				HStack {
					Button {
						self.isModalPresented = false
					} label: {
						Text("취소하기")
					}
					.padding()
					
					Spacer()
					Button("담기") {
						updateNewIngredient()
						self.isModalPresented = false
						self.updatedNewIngredient = true
					}
					.disabled(newUsersIngredientPicks.count != newIngredientArr.count)
					.padding()
				}
				
				Spacer()
				
				Divider()

				ForEach(newIngredientArr) { ingredient in
					EachAddIngredientViewCell(eachIngredient: ingredient,
											  categoryList: ingredientCategoryList,
											  saveWhereList: ingredientSaveWhereList,
											  isModalPresented: $isModalPresented,
											  updatedNewIngredient: $updatedNewIngredient, newUsersIngredientPicks: $newUsersIngredientPicks)
					.padding(.horizontal)
					
					Divider()
					
				}
			}
		} else {
			Text("이 화면엔 어떻게 온거죠..? \n 추가할 재료를 먼저 골라주세요 🥲")
		}
	}
	
	private func updateNewIngredient() {
		for newIngredient in newUsersIngredientPicks {
			guard let name = newIngredient.name,
				  let category = newIngredient.category,
				  let icon = newIngredient.icon,
				  let saveWhere = newIngredient.saveWhere,
				  let addCounter = newIngredient.addCounter,
				  let ingredientUnit = newIngredient.ingredientUnit else { break }
			
			ingredientManager.updateDictionary(eachIngredients: Ingredient(icon: icon, category: category, ingredient: name, ishave: true, saveWhere: saveWhere, addCounter: addCounter, ingredientUnit: ingredientUnit))
		}
		print("Modal", ingredientManager.ingredientsDictionary)
	}
}

