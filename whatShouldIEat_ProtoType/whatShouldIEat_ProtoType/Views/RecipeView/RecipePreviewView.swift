//
//  RecipePreviewView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/12/01.
//

import SwiftUI

struct RecipePreviewView: View {
    @Binding var selectedRecipe : EachRecipeDetail
    @State private var enablePagesImg : [String] = []
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(enablePagesImg.indices, id: \.self) { index in
                    
                    NavigationLink {
                        RecipePageTabView(selectedRecipe: $selectedRecipe, selectedTag: index)
                    } label: {
                        Page(urlString: enablePagesImg[index], size: 120)
                            .overlay(alignment : .bottomLeading) {
                                Text(String(index+1))
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .frame(width: 25, height: 25)
                                    .background(Color.accentColor)
                                    .cornerRadius(10)
                                    .offset(y: -20)
                            }
                    }
                }
            }
        }
        .onAppear{
            enablePagesImg = selectedRecipe
                .recipeInfoDetailList
                .filter{!$0.img.isEmpty}
                .map{$0.img}
        }
    }
}




//struct RecipePreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipePreviewView()
//    }
//}
