//
//  MoveTabView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/08.
//

import SwiftUI

struct MoveTabView: View {
	@EnvironmentObject var ingredientManager: IngredientStore
	
    var body: some View {
        TabView {
            NavigationView{
				HomeView()
            }.tabItem {
                Image(systemName: "refrigerator.fill")
                Text("나의 냉장고")
            }


            RecipeListView()
                .tabItem {
                Image(systemName: "doc.text.image")
                Text("레시피")
            }
        }
    }
}

struct MoveTabView_Previews: PreviewProvider {
    static var previews: some View {
        MoveTabView()
    }
}
