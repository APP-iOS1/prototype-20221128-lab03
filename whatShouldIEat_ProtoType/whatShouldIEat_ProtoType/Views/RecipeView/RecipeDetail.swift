//
//  RecipeDetail.swift
//  whatShouldIEat_ProtoType
//
//  Created by Deokhun KIM on 2022/11/08.
//

import SwiftUI

struct RecipeDetail: View {
    @Binding var selectedRecipe: EachRecipeDetail
    
    // URL 관련 값들
    @State var isRecipeMediaOn : Bool = false
    let ingredients = ingredientData
    
    let columns = [
        //추가 하면 할수록 화면에 보여지는 개수가 변함
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        // URL 관련 변수
        let urlStr = "https://www.youtube.com/results?search_query=\(selectedRecipe.RCP_NM.components(separatedBy: " ").joined(separator: "+"))"
        let encodedStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        
        ScrollView {
            HStack {
                Text(selectedRecipe.RCP_NM)
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
           /*
                Button {
                    selectedRecipe.isBookmark.toggle()
                } label: {
                    Image(systemName: selectedRecipe.isBookmark ? "bookmark.fill" : "bookmark")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                }
                */
            }
            
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: selectedRecipe.ATT_FILE_NO_MK)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                } placeholder: {
                    ProgressView()
                }
                
                Text(selectedRecipe.HASH_TAG)
                    .font(.title2)
                    .padding(.bottom, 20)
                    .foregroundColor(.gray)
                
                HStack {
                    Image(systemName: "person.fill.questionmark")
                    Text("\(Int.random(in: 1...4))인분")
                    Image(systemName: "clock.badge.questionmark")
                    Text("\(Int.random(in: 15...30))분")
                    Image(systemName: "text.book.closed.fill")
                    Text(["상","중","하"].randomElement()!)
                    
                }
                .font(.title3)
                .padding(.trailing, 10)
                .padding(.bottom, 20)
                
                Divider()
                
                Text("식재료")
                    .font(.title)
                    .foregroundColor(.gray)
                
                Text(selectedRecipe.RCP_PARTS_DTLS)
                    .font(.title3)
                
                /*
                LazyVGrid(columns: columns) {
                    ForEach(selectedRecipe.ingredients, id: \.self) {item in
                        let icon = ingredients.filter{$0.ingredient == item}.first?.icon ?? ""
                        VStack {
                            Image(icon)
                                .resizable()
                                .frame(width : 30, height: 30)
                            Text(item)
                                .font(.title3)
                        }
                    }
                }
                 */
                
                
                Divider()
                
                Text("레시피")
                    .font(.title)
                    .foregroundColor(.gray)
                
                NavigationLink {
                    RecipeDetailPageView(selectedRecipe: $selectedRecipe)
                } label: {
                    HStack {
                        Image(systemName: "doc.richtext")
                        Text("레시피 보러가기")
                        Spacer()
                    }
                    .font(.title3)
                }

                /*
                VStack(alignment: .leading,spacing: 25) {
                    ForEach(0..<selectedRecipe.recipe.count, id: \.self) { index in
                        HStack(alignment: .top){
                            Text(String(index + 1))
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .padding(.leading, 8)
                                .padding(.trailing, 12)
                                .padding(.top, -4)
                            
                            Text(selectedRecipe.recipe[index])
                                .font(.title3)
                                .lineSpacing(7.2385)
                        }
                    }
                }
                 */
                
            }
            
            Button {
                isRecipeMediaOn = true
            } label: {
                HStack {
                    Image(systemName: "play.rectangle.fill")
                    Text("레시피 영상 보기")
                    Spacer()
                }
                .foregroundColor(.red)
                .font(.title3)
                .padding(.vertical, 20)
            }
            .sheet(isPresented: $isRecipeMediaOn) {
                SafariView(url: url)
            }
            
        }
        .padding()
        .padding(.top, -20)
    }
}



//struct RecipeDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDetail()
//    }
//}
