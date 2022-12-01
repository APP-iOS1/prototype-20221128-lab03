//
//  MoveTabView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/08.
//

import SwiftUI

struct MoveTabView: View {
	@EnvironmentObject var ingredientManager: IngredientStore
	@ObservedObject var recipeStore = RecipeStore()
    
    var body: some View {
        TabView {
            NavigationStack{
				HomeView()
            }.tabItem {
                Image(systemName: "refrigerator.fill")
                Text("나의 냉장고")
            }

            RecipeListView(recipeStore: recipeStore)
                .tabItem {
                Image(systemName: "doc.text.image")
                Text("레시피")
            }
        }
        .onAppear {
            Task {
                var recipeNetwork = RecipeNetworkModel()
                await recipeNetwork.parsing()
                print("A")
                guard let data = recipeNetwork.allRecipeData else {
                    return
                }
                print("B")
                recipeStore.recipes2 = data.COOKRCP01.row
            }
        }
    }
}

struct MoveTabView_Previews: PreviewProvider {
    static var previews: some View {
        MoveTabView()
    }
}
