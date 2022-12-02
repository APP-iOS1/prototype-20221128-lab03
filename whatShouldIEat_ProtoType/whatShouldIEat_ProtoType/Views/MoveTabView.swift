//
//  MoveTabView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/08.
//

import SwiftUI

struct MoveTabView: View {
	@EnvironmentObject var ingredientManager: IngredientStore
    @ObservedObject var recipeStore : RecipeStore
    @State var tagSelection : Int = 0
    @State var isAvailableRecipes : Bool = false

    var body: some View {
        
        TabView(selection : $tagSelection) {
			NavigationStack {
				HomeView(isAvailableRecipes: $isAvailableRecipes,
						 tagSelection: $tagSelection)
			}
                .tabItem {
                    Image(systemName: "refrigerator.fill")
                    Text("나의 냉장고")
                }
                .tag(0)
                
			NavigationStack {
				RecipeListView(recipeStore: recipeStore,
							   isAvailableRecipes: $isAvailableRecipes)
			}
                .tabItem {
                    Image(systemName: "doc.text.image")
                    Text("레시피")
                }
                .tag(1)
        }
    }
}

struct MoveTabView_Previews: PreviewProvider {
    static var previews: some View {
        MoveTabView(recipeStore: RecipeStore())
    }
}
