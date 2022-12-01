//
//  RecipePageTabView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/12/01.
//

import SwiftUI

struct Page : View {
    let urlString : String
    let size : CGFloat
    var body: some View {
        
        AsyncImage(url: URL(string: urlString)) { image in
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(15)
                
        } placeholder: {
            ProgressView()
        }
        .frame(width: size, height: size)
        .shadow(color: .primary, radius: 1, x: 2, y: 2)
    }
}

struct RecipePageTabView : View {
    
    @Binding var selectedRecipe : EachRecipeDetail
    @State var enablePages : [(img : String, description : String)] = []
    @State var enablePagesImg : [String] = []
    @State var enablePagesDescription : [String] = []
    @State var selectedTag : Int
    
    var body: some View {
        
        TabView(selection:$selectedTag) {
            ForEach(enablePagesImg.indices, id: \.self) {index in
                ZStack {
                    VStack {
                        Page(urlString: enablePagesImg[index], size: 200)
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

//struct RecipePageTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipePageTabView()
//    }
//}
