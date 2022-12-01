//
//  RecipeDetailPageView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/30.
//

import SwiftUI

struct RecipeDetailPageView: View {
    
    @Binding var selectedRecipe : EachRecipeDetail
    @State private var enablePages : [(img : String, description : String)] = []
    
    var body: some View {
        ScrollView{
            
            AsyncImage(url: URL(string: selectedRecipe.ATT_FILE_NO_MK)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
            } placeholder: {
                ProgressView()
            }
            
            HStack {
                Text(selectedRecipe.RCP_NM)
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading, 20)
                Spacer()
            }
            
            HStack {
                VStack(alignment : .leading) {
                    ForEach(enablePages.indices, id: \.self) {index in
                        Page(urlString: enablePages[index].img, size: 120)
                        Text(enablePages[index].description)
                            .padding(.top, -20)
                    }
                    .padding(.bottom, 20)
                    
                    Spacer()
                }
                .padding(.leading, 20)
                Spacer()
            }
        }
        .onAppear {
            enablePages = selectedRecipe.recipeInfoDetailList.filter{!$0.img.isEmpty}
        }
    }
        
}



//struct RecipeDetailPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDetailPageView()
//    }
//}
