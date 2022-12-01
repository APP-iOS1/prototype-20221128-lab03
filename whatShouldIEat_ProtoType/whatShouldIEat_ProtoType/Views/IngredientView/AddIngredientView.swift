import SwiftUI

struct AddIngredientView: View {
	
	@ObservedObject var ingredientStore: IngredientStore
	@Environment(\.dismiss) private var dismiss
	
	@State private var selectedItemCounter = 0
	@State private var isItemSelected = false
	@State private var isModalPresented = false
	@State private var isReciptModalPresented = false
	@State private var newIngredientArr = [NewIngredient]()
    @State private var newReciptIngredient: [String] = ["우유", "돼지고기", "플레인요거트"]
	
	let gridSystem = [
		//추가 하면 할수록 화면에 보여지는 개수가 변함
		GridItem(.flexible(), spacing: 7.5, alignment: .top),
		GridItem(.flexible(), spacing: 7.5, alignment: .top),
		GridItem(.flexible(), spacing: 7.5, alignment: .top),
		GridItem(.flexible(), spacing: 7.5, alignment: .top)
	]
	
	var body: some View {
		ScrollView {
			Text("추가하실 재료를 선택해 주세요")
				.font(.title)
				.bold()
				.padding()
			
			// 나중에 서치뷰 구현
			// SearchView()
			
			VStack(alignment: .leading, spacing: 20) {
				ForEach(ingredientStore.ingredientCategoryList, id: \.self) { categoryKey in
					// categoryKey == Header, DictionaryKey
					HStack {
						Text(categoryKey)
							.font(.title2)
							.foregroundColor(.blue)
							.fontWeight(.bold)
						
						Spacer()
						
						Text("\(selectedItemCounter)" + "개 선택됨")
					}
					.padding(.horizontal)
					
					Divider()
					
					if let foodDBArray = foodDb[categoryKey] {
						LazyVGrid(columns: gridSystem) {
							ForEach(foodDBArray, id: \.self) { eachFoodName in
								FoodLazyVGridView(eachFoodName: eachFoodName,
												  category: categoryKey,
												  foodDBArray: foodDBArray,
												  selectedItemCounter: $selectedItemCounter,
												  newIngredientArr: $newIngredientArr)
							}
						}
					}
				}
			}

			}
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
                    HStack{
                    Button("영수증 촬영하기"){
                        isReciptModalPresented.toggle()
                    }
                    .sheet(isPresented: $isReciptModalPresented) {
                        ReciptModalView(newIngredientArr: $newIngredientArr, isReciptModalPresented: $isReciptModalPresented, isModalPresendted: $isModalPresented)
                    }
                    
					Button("추가하기") {
						isModalPresented.toggle()
					}
                    .disabled(newIngredientArr.count > 0 ? false : true)
                    .sheet(isPresented: $isModalPresented) {
                        AddIngredientDetailModalView(isModalPresented: $isModalPresented,
                                                     newIngredientArr: $newIngredientArr)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                        })
                    }
				}
			}
			
		}
	}
}

struct FoodLazyVGridView: View {
	let eachFoodName: String
	let category: String
	
	@State var foodDBArray: [String]
	@State private var isItemSelected: Bool = false
	@Binding var selectedItemCounter: Int
	@Binding var newIngredientArr: [NewIngredient]
	
	var body: some View {
		VStack(spacing: 15) {
			Image(systemName: "star")
				.resizable()
				.frame(width: 30, height: 30)
			
			Text(eachFoodName)
				.frame(width: 90, height: 25)
		}
		.padding(.vertical, 3)
		.opacity(isItemSelected ? 1 : 0.7)
		.onTapGesture {
			isItemSelected.toggle()
			
			if isItemSelected {
				selectedItemCounter += 1
				newIngredientArr.append(NewIngredient(category: category,
													  name: eachFoodName))
			} else {
				selectedItemCounter -= 1
				for index in 0 ..< newIngredientArr.count {
					if newIngredientArr[index].name == eachFoodName {
						newIngredientArr.remove(at: index)
						break
					}
				}
			}
		}
	}
}

//
//
//struct CategoryAndIngredientsGridView: View {
//	@ObservedObject var ingredientStore: IngredientStore
//	@State private var counter: Int = 0
//
//	let category: String
//
//	let columns = [
//		//추가 하면 할수록 화면에 보여지는 개수가 변함
//		GridItem(.flexible()),
//		GridItem(.flexible()),
//		GridItem(.flexible()),
//		GridItem(.flexible())
//	]
//
//	var body: some View {
//		HStack { // 각 카테고리의 제목 및 선택된 재료의 개수 표시
//			Text(category)
//				.font(.title2)
//				.foregroundColor(.blue)
//				.fontWeight(.bold)
//
//			Spacer()
//
//			Text("\(counter)개 선택됨")
//		}
//
//		ScrollView {
//			LazyVGrid(columns: columns) {
//				ForEach($ingredientStore.ingredients) { ingredient in
//					if ingredient.wrappedValue.category == category,
//					   let eachFood = foodDb[category] {
//						ForEach(eachFood, id: \.self) { eachFoodNames in
//							Text(eachFoodNames)
//						}
//						let _ = print(eachFood, ingredientStore.ingredients)
//						//
//						//						CombinationIngredientView(ingredient: ingredient,
//						//												  counter: $counter)
//					}
//				}
//			}
//		}
//	}
//}
//
//struct CombinationIngredientView: View {
//	@Binding var ingredient: Ingredient
//	@Binding var counter: Int
//	@State private var isSelected: Bool = false
//
//	var body: some View {
//		VStack {
//			Image(ingredient.icon)
//				.resizable().frame(width: 50, height: 50)
//				.opacity(isSelected ? 1 : 0.5)
//				.onTapGesture {
//					if isSelected {
//						counter -= 1
//					} else {
//						counter += 1
//					}
//					isSelected.toggle()
//					ingredient.ishave.toggle()
//				}
//
//			Text(ingredient.ingredient)
//		}
//	}
//}
//
//struct AddIngredientView_Previews: PreviewProvider {
//	static var previews: some View {
//		AddIngredientView(ingredientStore: IngredientStore())
//	}
//}
