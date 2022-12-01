//
//  RecipeListView2.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/09.
//

import SwiftUI
import Combine

struct RecipeListView: View {
    @ObservedObject var recipeStore : RecipeStore
    @State private var searchString : String = ""
    @State private var isBookmarkOn : Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                searchBar(text: $searchString)
                    .padding()
                List {
                    ForEach($recipeStore.recipes2, id: \.RCP_PARTS_DTLS) { recipe in
                        if isBookmarkOn {
                            if recipe.wrappedValue.isBookmark ?? false {
                                ListCell(recipe: recipe)
                            }
                        } else {
                            ListCell(recipe: recipe)
                        }
                         
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("레시피")
                            .font(.largeTitle)
                            .accessibilityAddTraits(.isHeader)
                    }
                }
                .navigationBarItems(trailing : Button {
                    isBookmarkOn.toggle()
                } label: {
                    Image(systemName: isBookmarkOn ? "bookmark.fill" : "bookmark")
                        .font(.title)
                        .foregroundColor(.blue)
                })
            }
        }
    }
}
        
        
        
        
        
        
    



struct ListCell: View {
    @Binding var recipe: EachRecipeDetail
    
    var body: some View {
        NavigationLink(destination: RecipeDetail(selectedRecipe: $recipe)) {
            HStack {
                ZStack {
                    AsyncImage(url: URL(string: recipe.ATT_FILE_NO_MK)) { image in
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                    } placeholder: {
                        ProgressView()
                    }

                    if recipe.isBookmark ?? false {
                        Image(systemName: "bookmark.fill")
                            .foregroundColor(.blue)
                            .offset(x : 35, y : -35)
                            .overlay {
                            }
                    }
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    HStack {
                        Text(recipe.RCP_NM)
                            .font(.title2)
                            .fontWeight(.medium)
                            .frame(width : 200,alignment: .leading)
                        
                        
                    }
//                    IconCell(recipe: recipe)
                }
            }
        }
    }
}

struct IconCell : View {
	@EnvironmentObject var ingredientStore: IngredientStore
    
    let recipe: Recipe
	
    var needIngredients: [String] {
        recipe.ingredients.count > 5 ? Array(recipe.ingredients[0...4]) :
        recipe.ingredients
    }
    
    var body: some View {
        let ingredients = ingredientStore.ingredients
		
		// 기본 재료 JSON을 파싱하고, 그 파싱 데이터의 아이콘 이름으로 이미지 구성
		HStack {
            ForEach(needIngredients, id: \.self) { item in
                let icon: String = ingredients.filter {
					$0.ingredient == item
				}.first?.icon ?? ""

                Image(icon)
                    .resizable()
                    .frame(width:20,
						   height:20)
            }
        }
    }
}

struct searchBar: View {
    
    @Binding var text : String
    @State var editText : Bool = false
    
    var body: some View {
        HStack{
            
            TextField("레시피를 입력해주세요" , text : self.$text)
                .padding(15)
                .padding(.horizontal,15)
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .overlay(
                    HStack{
                        Spacer()
                        if self.editText{
                            Button(action : {
                                self.editText = false
                                self.text = ""
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }){
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(Color(.black))
                                    .padding()
                            }
                        }else{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(.black))
                                .padding()
                        }
                        
                    }
                ).onTapGesture {
                    self.editText = true
                }
        }
    }
}

//struct RecipeListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeListView()
//    }
//}
