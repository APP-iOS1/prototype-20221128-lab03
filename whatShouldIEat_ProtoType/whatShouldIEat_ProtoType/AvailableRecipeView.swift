//
//  AvailableRecipeView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/09.
//

import SwiftUI
import Combine

struct AvailableRecipeView: View {
    
    @ObservedObject var recipeStore = RecipeStore(recipes: recipeData)
    
    
    var body: some View {
        
        
        NavigationView {
            List {
                ForEach($recipeStore.recipes) { recipe in
                    ListCell(recipe: recipe)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("냉장고 터는 레시피")
                        .font(.largeTitle)
                        .accessibilityAddTraits(.isHeader)
                }
            }
        }
    }
}

struct AvailableListCell: View {
    @Binding var recipe: Recipe
    
    var body: some View {
        NavigationLink(destination: RecipeDetail(selectedRecipe: $recipe)) {
            HStack {
                Image(recipe.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(15)
                VStack(alignment: .leading, spacing: 10) {
                    Text(recipe.dish)
                        .font(.title)
                        .fontWeight(.medium)

                    Text(recipe.description)
                        .font(.body)
                        .foregroundColor(.gray)
                }
            }
        }

    }
}


struct AvailableRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AvailableRecipeView()
    }
}
