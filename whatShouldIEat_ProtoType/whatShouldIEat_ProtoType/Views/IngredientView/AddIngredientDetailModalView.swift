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
	
	// State 배열 만들고 하위 뷰에서 이 배열에 어펜드하도록 한 다음 업데이트 버튼을 누르면
	// 이 배열을 반복해서 어펜드
	
	var body: some View {
		let ingredientCategoryList = ingredientManager.ingredientCategoryList
        let ingredientSaveWhereList = ingredientManager.ingredientSaveWhereList
		
		if !newIngredientArr.isEmpty {
			ScrollView {
				ForEach(newIngredientArr) { ingredient in
					EachAddIngredientViewCell(eachIngredient: ingredient,
											  categoryList: ingredientCategoryList,
                                              saveWhereList: ingredientSaveWhereList,
                                              isModalPresented: $isModalPresented,
                                              updatedNewIngredient: $updatedNewIngredient)
					.padding()
				}
			}
		} else {
			Text("이 화면엔 어떻게 온거죠..? \n 추가할 재료를 먼저 골라주세요 🥲")
		}
	}
}


struct EachAddIngredientViewCell: View {
	let eachIngredient: NewIngredient
	let categoryList: [String]
    let saveWhereList : [Ingredient.SaveWhere]
    
	
	@EnvironmentObject var ingredientManager: IngredientStore
	@Binding var isModalPresented: Bool
	@Binding var updatedNewIngredient: Bool
	
	@State private var checkUsersInputToTransition = false
	@State private var buyDate: Date = Date.now
	@State private var expiredDate: Date = Calendar.current.date(byAdding: .day, value: 5, to: .now)!
    @State private var saveWhere : Ingredient.SaveWhere = .refrigeration
	
	
	@State private var addCounter: String = "" {
		didSet {
			let filtered = addCounter.filter { $0.isNumber }
			
			if addCounter != filtered {
				addCounter = filtered
			}
		}
	}
	
	@State private var ingredientUnit: IngredientUnit = .piece
	@State private var usersCategory: String = ""
	
	var body: some View {
		VStack {
			HStack {
				Button {
					self.isModalPresented = false
				} label: {
					Text("취소하기")
				}
				
				Spacer()
				
                Button("추가하기") {
                    updateNewIngredient()
                    self.isModalPresented = false
                    self.updatedNewIngredient = true
                }
                .disabled(addCounter.isEmpty)
			}
			.padding()
			
			Divider()
			
			VStack(alignment: .leading) {
				
				Picker("분류 :", selection: $usersCategory) {
					ForEach(categoryList, id: \.self) { category in
						usersCategoryPickerBuilder(category,
												   ingredient: eachIngredient)
					}
				}
				.pickerStyle(.segmented)
				.onAppear {
					if usersCategory == "" {
						self.usersCategory = eachIngredient.category
					}
				}
				
				HStack {
					Text("분류 : ")
					Spacer()
					Text("\(usersCategory)")
				}
				
				.padding(.bottom)
				
				HStack {
					Text("재료 : ")
					Spacer()
					Text("\(eachIngredient.name)")
				}
				
				HStack {
					Text("구매 날짜 : ")
					
					DatePicker("", selection: $buyDate,
							   displayedComponents: .date)
					.datePickerStyle(.compact)
				}
				
				HStack {
					Text("예상 유통기한 : ")
					
					DatePicker("", selection: $expiredDate,
							   displayedComponents: .date)
					.datePickerStyle(.compact)
				}
				
				HStack {
					Text("보관 방법 : ")
                    
                    Spacer()
					
                    Picker("", selection: $saveWhere) {
                        ForEach(saveWhereList, id: \.self) {saveWhere in
                            Text(saveWhere.rawValue)
                        }
                    }
				}
				
				HStack {
					Text("보관 분량 : ")
						.padding(.trailing, 5)
					
					Spacer()
					
					HStack {
						VStack(alignment: .leading) {
							TextField("0", text: $addCounter)
								.autocorrectionDisabled()
								.textInputAutocapitalization(.never)
								.textFieldStyle(.roundedBorder)
								.keyboardType(.decimalPad)
								.tag(addCounter)
							
							if checkUsersInputToTransition {
								Text("숫자만 입력해주세요")
									.font(.callout)
									.transition(.slide)
							}
						}
						
						Picker("", selection: $ingredientUnit) {
							ForEach(IngredientUnit.allCases) { unitName in
								Text(unitName.rawValue)
									.tag(unitName.id)
							}
							.labelsHidden()
						}
						.pickerStyle(.menu)
					}
				}
			}
			.font(.headline)
		}
		.listStyle(.inset)
	}
	
	
	@ViewBuilder
	private func usersCategoryPickerBuilder(_ categories: String,
											ingredient: NewIngredient) -> some View {
		switch categories {
		case ingredient.category:
			Text(ingredient.category)
		case "기타":
			Text("기타")
		default:
			EmptyView()
		}
	}
	
	private func updateNewIngredient() {
		ingredientManager.updateDictionary(
            eachIngredients: Ingredient(icon: categoryImageDB[eachIngredient.category] ?? "guitar", category: usersCategory, ingredient: eachIngredient.name, ishave: true, saveWhere: saveWhere, buyDate: buyDate, expiredDate: expiredDate, addCounter: addCounter, ingredientUnit: ingredientUnit))
		print("Modal", ingredientManager.ingredientsDictionary)
	}
}

