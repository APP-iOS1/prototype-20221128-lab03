//
//  RecipeDetailPageView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/30.
//

import SwiftUI

struct RecipeDetailPageView: View {
    
    @Binding var selectedRecipe : EachRecipeDetail
    
    var body: some View {
        
        
        
        myPages(selectedRecipe: $selectedRecipe)
        
        
    }
}

struct Page : View {
    let urlString : String
    var body: some View {
        
        AsyncImage(url: URL(string: urlString)) { image in
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(15)
                
        } placeholder: {
            ProgressView()
        }
        .frame(width: 160, height: 160)
        
        
    }
}

struct myPages : View {
    
    @Binding var selectedRecipe : EachRecipeDetail
    @State var enablePages : [(img : String, description : String)] = []
    @State var enablePagesImg : [String] = []
    @State var enablePagesDescription : [String] = []
    @State var selectedTag : Int = 0
    
    var body: some View {
        
        TabView(selection:$selectedTag) {
            ForEach(enablePagesImg.indices, id: \.self) {index in
                ZStack {
                    VStack {
                        Page(urlString: enablePagesImg[index])
                        Text(enablePagesDescription[index])
                    }
                    .tag(index)
                    GeometryReader { geometry in
                        HStack {
                            Rectangle()
                                .opacity(0.001)
                                .frame(width: geometry.size.width / 2)
                                .onTapGesture {
                                    if selectedTag > 0 {
                                        selectedTag -= 1
                                    }
                                }
                            Rectangle()
                                .opacity(0.001)
                                .frame(width: geometry.size.width / 2)
                                .onTapGesture {
                                    if selectedTag < enablePagesImg.count-1 {
                                        selectedTag += 1
                                    }
                                }
                        }
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        // .never 로 하면 배경 안보이고 .always 로 하면 인디케이터 배경 보입니다.
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .onAppear {
            enablePages = selectedRecipe.recipeInfoDetailList.filter{!$0.img.isEmpty}
            enablePagesImg = enablePages.map{$0.img}
            enablePagesDescription = enablePages.map{$0.description}
            
        }
        
        
    }
    
    
}

//struct RecipeDetailPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDetailPageView()
//    }
//}
