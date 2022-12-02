//
//  ContentView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/08.
//

import SwiftUI

struct ContentView: View {

    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color(.systemGray6))
        }
    
    @ObservedObject var recipeStore = RecipeStore()

    var body: some View {
        MoveTabView(recipeStore: recipeStore)
            .onAppear {
                Task {
                    let recipeNetwork = RecipeNetworkModel()
                    await recipeNetwork.parsing()
                    guard let data = recipeNetwork.allRecipeData else {
                        return
                    }
                    recipeStore.recipes2 = data.COOKRCP01.row
                    for index in 0..<recipeStore.recipes2.count{
                        recipeStore.recipes2[index].isBookmark = false
                    }
                }
            }
//        IngredientSampleView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
