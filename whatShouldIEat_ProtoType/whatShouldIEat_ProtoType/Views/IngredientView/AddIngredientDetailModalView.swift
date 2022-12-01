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
	@Binding var newIngredientArr: [NewIngredient]
	@State private var buyDate: Date = Date.now
	@State private var isFrozen: Bool = false
	@State private var addCounter = 1
	
    var body: some View {
		if !newIngredientArr.isEmpty {
			VStack {
				HStack {
					Button {
						self.isModalPresented = false
					} label: {
						Text("취소하기")
					}
					
					Spacer()
					
					Button {
						for ingredient in newIngredientArr {
							ingredientManager.updateDictionary(eachIngredients: Ingredient(icon: "star", category: ingredient.category, ingredient: ingredient.name, ishave: true))
						}
						print("Modal", ingredientManager.ingredientsDictionary)
						self.isModalPresented = false
					} label: {
						Text("추가하기")
					}
				}
				.padding()
				
				Divider()
				
				List(newIngredientArr) { ingredient in
					VStack(alignment: .leading) {
						Text("분류 : " + "\(ingredient.category)")
						
						Text("재료 : " + "\(ingredient.name)")
						
						HStack {
							Text("구매 날짜 : ")
							
							DatePicker("", selection: $buyDate,
									   displayedComponents: .date)
						}
						
						HStack {
							Text("냉동 여부 : ")
							
							Toggle("", isOn: $isFrozen)
						}
						
						HStack {
							Text("추가 개수 : ")
							
							Stepper("", value: $addCounter)
						}
					}
					.font(.headline)
				}
				.listStyle(.inset)
			}
		} else {
			Text("추가할 재료를 먼저 골라주세요 🥲")
		}
		
    }
}
