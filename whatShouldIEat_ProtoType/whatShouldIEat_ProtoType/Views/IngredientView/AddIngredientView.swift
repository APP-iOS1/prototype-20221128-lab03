import SwiftUI

struct AddIngredientView: View {
	
	@ObservedObject var ingredientStore: IngredientStore
	@Environment(\.dismiss) private var dismiss
	
	let categoryList: [String] = [
		"채소", "육류/달걀", "두부류", "유제품", "김치", "젓갈", "가루류", "오일류", "조미료/양념"
	]
	
	var body: some View {
		ScrollView {
			Text("추가하실 재료를 선택해 주세요")
				.font(.title)
				.bold()
				.padding()
			
			VStack(alignment: .leading, spacing: 50) {
				
				ForEach(categoryList, id: \.self) { category in
					CategoryAndIngredientsView(ingredientStore: ingredientStore, category: category)
						.padding([.leading, .trailing])
				}
			}
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button("추가하기") {
					dismiss()
				}
			}
		}
		.navigationBarBackButtonHidden(true)
		.navigationBarItems(leading: Button(action: {
			dismiss()
		}) {
			Image(systemName: "arrow.left")
		})
	}
	
    struct CategoryAndIngredientsView: View {
        @ObservedObject var ingredientStore: IngredientStore
        @State private var counter: Int = 0
        
        let category: String
        
        let columns = [
            //추가 하면 할수록 화면에 보여지는 개수가 변함
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        var body: some View {
            HStack { // 각 카테고리의 제목 및 선택된 재료의 개수 표시
                Text(category)
                    .font(.title2)
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("\(counter)개 선택됨")
            }
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach($ingredientStore.ingredients) { ingredient in
                        if ingredient.wrappedValue.category == category {
                            CombinationIngredientView(ingredient: ingredient, counter: $counter)
                        }
                    }
                }
            }
        }
    }
}

struct CombinationIngredientView: View {
    @Binding var ingredient: Ingredient
    @Binding var counter: Int
    @State private var isSelected: Bool = false
    
    var body: some View {
        VStack {
            Image(ingredient.icon)
                .resizable().frame(width: 50, height: 50)
                .opacity(isSelected ? 1 : 0.5)
                .onTapGesture {
                    if isSelected {
                        counter -= 1
                    } else {
                        counter += 1
                    }
                    isSelected.toggle()
                    ingredient.ishave.toggle()
                }
            Text(ingredient.ingredient)
        }
    }
}

struct AddIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientView(ingredientStore: IngredientStore())
    }
}
