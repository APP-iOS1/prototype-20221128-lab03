import SwiftUI

struct HomeView: View {
	@EnvironmentObject var ingredientStore: IngredientStore
	
    @State private var isAvailableView: Bool = false
    @State private var isAddViewShow: Bool = false

    let columns = [
        //추가 하면 할수록 화면에 보여지는 개수가 변함
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
//        let ingredientCount = ingredientStore.ingredients.filter { $0.ishave }.count
		let isMyIngredientEmpty = ingredientStore.ingredientsDictionary.isEmpty
//		let isMyFrozonIngredientEmpty = ingredientStore.ingredientsDictionary.values.filter { $0. }
		
        VStack {
            VStack(alignment: .leading) { // isHave ==  true인 재료가 보여짐
                if isMyIngredientEmpty {
                    VStack { // 가진 재료가 없을 때
                        Spacer()
                        Text("냉장고가 텅 비어 있어요.")
                        Text("우상단의 + 버튼을 눌러 재료를 추가해주세요.")
                        Spacer()
                    }
                } else {
                    Group {
                        Text("냉장실")
                            .font(.title)
                            .fontWeight(.semibold)
                            .frame(width: 350, height: 50, alignment: .leading)

                        if true {
                            VStack { // 냉장실에 재료가 없을 때
                                Spacer()
                                Text("냉장실이 텅 비어 있어요😭")
                                Spacer()
                            }
                        } else {
                            ScrollView {
                                LazyVGrid(columns: columns) {
									ForEach(ingredientData, id: \.self) { eachIngredient in
										let key = eachIngredient.ingredient
										if let myIngredient = ingredientStore.ingredientsDictionary[key] {
											ForEach(myIngredient, id: \.self) { str in
												Text(str.ingredient)
											}
										}
									}
									
//                                    ForEach($ingredientStore.ingredients) { ingredient in
//                                        if ingredient.wrappedValue.ishave && !ingredient.wrappedValue.isFrozen {
//                                            IngredientCell(ingredient: ingredient)
//                                        }
//                                    }
                                }
                            }
                        }
                    }

                    Divider()

                    Group {
                        Text("냉동실")
                            .font(.title)
                            .fontWeight(.semibold)
                            .frame(width: 350, height: 50, alignment: .leading)

                        let frozenIngredientCount = ingredientStore.ingredients.filter { $0.isFrozen }.count

                        if frozenIngredientCount == 0 {
                            VStack { // 냉장실에 재료가 없을 때
                                Spacer()
                                Text("냉동실이 텅 비어 있어요😭")
                                Spacer()
                            }
                        } else {
                            ScrollView {
                                LazyVGrid(columns: columns) {
                                    ForEach($ingredientStore.ingredients) { ingredient in
                                        if ingredient.wrappedValue.ishave && ingredient.wrappedValue.isFrozen {
                                            IngredientCell(ingredient: ingredient)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Spacer()

            if isMyIngredientEmpty {
                Text("냉장고 털러가기")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 150, height: 40)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .onTapGesture { isAvailableView = true }
//                    .sheet(isPresented: $isAvailableView) { AvailableRecipeView() }
            }
            
        } // main Vstack
        .padding(20)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
            ToolbarItem(placement: .principal) {
                Text("나의 냉장고")
                    .font(.largeTitle)
                    .accessibilityAddTraits(.isHeader)
            }
        }
            .navigationBarItems(trailing: NavigationLink {
            AddIngredientView(ingredientStore: ingredientStore)
        } label: {
                Image(systemName: "plus").foregroundColor(.blue)
            })
    }// body

}

struct IngredientCell: View {
    @Binding var ingredient: Ingredient
    @State private var isShowing: Bool = false

    var body: some View {

        Button {
            isShowing.toggle()
        } label: {
            VStack(spacing: 10) {
                Image(ingredient.icon)
                    .resizable()
                    .frame(width: 30, height: 30)
                Text(ingredient.ingredient)
                    .foregroundColor(.black)
                //                    .fontWeight(.semibold)
            }
        }
            .sheet(isPresented: $isShowing) {
            IngredientDetailView(
                isShowing: $isShowing,
                ingredient: $ingredient
            )
                .presentationDetents([.medium, .large])
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
