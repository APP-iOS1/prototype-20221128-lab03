//
//  EachAddIngredientViewCell.swift
//  whatShouldIEat_ProtoType
//
//  Created by 이승준 on 2022/12/02.
//

import SwiftUI

struct EachAddIngredientViewCell: View {
	let eachIngredient: NewIngredient
	let categoryList: [String]
	let saveWhereList : [Ingredient.SaveWhere]
	
	@EnvironmentObject var ingredientManager: IngredientStore
	@Binding var isModalPresented: Bool
	@Binding var updatedNewIngredient: Bool
	@Binding var newUsersIngredientPicks: [UsersNewIngredient]
	
	@State private var isAddedNewIngredient: Bool = false
	
	/// 유저가 AddIngredientViewCell에서 추가한 재료들의 데이터 State
	@State private var usersNewIngredient: UsersNewIngredient?
	
	// 내부에서 유저 정보를 받아서 구조체를 만드는 프로퍼티목록
	@State private var buyDate: Date = Date.now
	@State private var expiredDate: Date = Calendar.current.date(byAdding: .day, value: 5, to: .now)!
	@State private var saveWhere : Ingredient.SaveWhere = .refrigeration
	@State private var addCounter: String = ""
	@State private var ingredientUnit: IngredientUnit = .piece
	@State private var usersCategory: String = ""
	
	var body: some View {
		VStack {
			// 섹션 헤더가 반복되지 않도록 상위뷰로 꺼내기
			HStack {
				if isAddedNewIngredient {
					Button {
//						self.isModalPresented = false
						self.isAddedNewIngredient = false
						self.usersNewIngredient = nil
					} label: {
						Text("꺼내기")
					}
					Spacer()
				}
				
				Button {
					addNewIngredient()
					self.isAddedNewIngredient = true
				} label: {
					if isAddedNewIngredient {
						VStack {
							Image(systemName: "checkmark.circle.fill")
							Text("보관했습니다!")
								.font(.callout)
								.foregroundColor(Color(.systemGray4))
								.padding(.top, 5)
						}
					} else {
						Text("냉장고에 담기")
					}
				}
				.disabled(addCounter.isEmpty)

			}
			.padding()
			
			Divider()
			
			VStack(alignment: .leading) {
				
				selectedIngredientCategory
				
				newIngredientName
				
				ingredientBuyDate
				
				estimatedExpiredDate
				
				howToSaveIngredientView
				
				howManyIngredientsView
			}
			.font(.headline)
		}
		.listStyle(.inset)
	}
	
	private var selectedIngredientCategory: some View {
		Group {
			HStack {
				Text("분류 : ")
				Spacer()
				Text("\(usersCategory)")
			}
			
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
		}
	}
	
	private var newIngredientName: some View {
		HStack {
			Text("재료 : ")
			Spacer()
			Text("\(eachIngredient.name)")
		}
	}
	
	private var ingredientBuyDate: some View {
		HStack {
			Text("구매 날짜 : ")
			
			DatePicker("", selection: $buyDate,
					   displayedComponents: .date)
			.datePickerStyle(.compact)
		}
	}
	
	private var estimatedExpiredDate: some View {
		HStack {
			Text("예상 유통기한 : ")
			
			DatePicker("", selection: $expiredDate,
					   displayedComponents: .date)
			.datePickerStyle(.compact)
		}
	}
	
	private var howToSaveIngredientView: some View {
		HStack {
			Text("보관 방법 : ")
			
			Spacer()
			
			Picker("", selection: $saveWhere) {
				ForEach(saveWhereList, id: \.self) {saveWhere in
					Text(saveWhere.rawValue)
				}
			}
		}
	}
	
	private var howManyIngredientsView: some View {
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
	
	private func addNewIngredient() {
		self.usersNewIngredient = UsersNewIngredient(category: usersCategory, name: eachIngredient.name, icon: categoryImageDB[eachIngredient.category], saveWhere: saveWhere, buyDate: buyDate, expiredDate: expiredDate, addCounter: addCounter, ingredientUnit: ingredientUnit)
		print(usersNewIngredient!)
		
		guard let usersNewIngredient else { return }
		self.newUsersIngredientPicks.append(usersNewIngredient)
	}
}


struct UsersNewIngredient: Identifiable {
	public var id = UUID().uuidString
	public var category: String?
	public var name: String?
	public var icon: String?
	
	// 각각의 감자를 따로 얼리도록 구현
	
	public var saveWhere: Ingredient.SaveWhere?
	
	public var buyDate: Date?
	public var expiredDate: Date?
	public var addCounter: String?
	public var ingredientUnit: IngredientUnit?
}
