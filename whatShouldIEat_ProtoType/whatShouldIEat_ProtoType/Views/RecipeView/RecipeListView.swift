//
//  RecipeListView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/09.
//

#if canImport(UIKit)
extension View{
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

import SwiftUI
import Combine

struct RecipeListView: View {
    @EnvironmentObject var ingredientStore : IngredientStore
    @ObservedObject var recipeStore : RecipeStore
    @State private var searchString : String = ""
    @State private var isBookmarkOn : Bool = false
    @Binding var isAvailableRecipes : Bool
    
    var body: some View {
            //NavigationStack {
                VStack {
                    searchBar(text: $searchString)
                        .padding()
                    ScrollView {
                        ForEach($recipeStore.recipes2, id: \.RCP_PARTS_DTLS) { $recipe in
//                            if recipe.isBookmark == nil{
//                                recipe.isBookmark = false
//                            }
                            if searchString == "" {
                                if isAvailableRecipes {
                                    let parseIngredients = recipeStore.parseIngredients(recipe.RCP_PARTS_DTLS).map{$0.name}
                                    
                                    if ingredientStore.isHaveAllNeedIngredients(needIngredientsName: parseIngredients) {
                                        ListCell(recipe: $recipe)
                                    }
                                } else if isBookmarkOn {
                                    if recipe.isBookmark ?? false {
                                        ListCell(recipe: $recipe)
                                    }
                                } else {
                                    ListCell(recipe: $recipe)
                                }
                            } else if recipe.RCP_NM.contains(searchString) {
                                if isAvailableRecipes {
                                    let parseIngredients = recipeStore.parseIngredients(recipe.RCP_PARTS_DTLS).map{$0.name}
                                    
                                    if ingredientStore.isHaveAllNeedIngredients(needIngredientsName: parseIngredients) {
                                        ListCell(recipe: $recipe)
                                    }
                                } else if isBookmarkOn {
                                    if recipe.isBookmark ?? false {
                                        ListCell(recipe: $recipe)
                                    }
                                } else {
                                    ListCell(recipe: $recipe)
                                }
                            }
                             
                             
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("레시피")
                                .font(.largeTitle)
                                .accessibilityAddTraits(.isHeader)
                        }
                    }
                    .navigationBarItems(leading : Button(action: {
                        isAvailableRecipes.toggle()
                    }, label: {
                        Text(isAvailableRecipes ? "조리 가능" : "전체")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width : 100)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    })
                    ,trailing : Button {
                        isBookmarkOn.toggle()
                    } label: {
                        Image(systemName: isBookmarkOn ? "bookmark.fill" : "bookmark")
                            .font(.title2)
                            .foregroundColor(.blue)
                    })
                }
           // }
            .onTapGesture{
                hideKeyboard()
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
                }
            }
        }
    }
}

struct searchBar: View {
    
    @Binding var text : String
    @State var editText : Bool = false
    
    var body: some View {
        HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                
                TextField("레시피를 입력해주세요", text: self.$text)
                if !text.isEmpty{
                    Button(action: {
                        self.text = ""
                    }){
                        Image(systemName: "xmark.circle.fill")
                    }
                } else{
                    EmptyView()
                }
            }
            .padding(15)
            .padding(.horizontal, 15)
            .background(Color(.systemGray6))
            .cornerRadius(15)
        }
        /*
         HStack{
         HStack{
         Image(systemName: "magnifyingglass")
         
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
         */
    }
}



//struct RecipeListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeListView(recipeStore: RecipeStore())
//    }
//}

