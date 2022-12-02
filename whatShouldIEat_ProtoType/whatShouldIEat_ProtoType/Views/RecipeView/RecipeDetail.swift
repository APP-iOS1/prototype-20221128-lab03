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
            // 메인 이미지
            AsyncImage(url: URL(string: selectedRecipe.ATT_FILE_NO_MK)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
            } placeholder: {
                ProgressView()
            }
            
            // 음식 이름과 북마크 버튼
            HStack {
                Text(selectedRecipe.RCP_NM)
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
           
                Button {
                    selectedRecipe.isBookmark?.toggle()
                } label: {
                    if let isBookmark = selectedRecipe.isBookmark {
                        Image(systemName: isBookmark ? "bookmark.fill" : "bookmark")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                }
            }
            
            
            VStack(alignment: .leading, spacing: 10) {
                
                // 인원수, 조리시간, 난이도 랜덤 값
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
                
                // MARK: 식재료 설명 파트
                Text("식재료")
                    .font(.title)
                    .foregroundColor(.gray)
                
                // 식재료 리스트 출력
                let ingredientsDetails : [(name : String, yang : String)] = RecipeStore().parseIngredients(selectedRecipe.RCP_PARTS_DTLS)
                ForEach(ingredientsDetails.indices, id: \.self) { index in
                    let ingredient = ingredientsDetails[index]
                    Text("\(ingredient.name) \(ingredient.yang)")
                        .font(.title3)
                }
                
                
                
                Divider()
                
                // MARK: 레시피 파트
                Text("레시피")
                    .font(.title)
                    .foregroundColor(.gray)
                
                Text("미리보기")
                    .font(.title3)
                    .padding(.bottom,-30)
                RecipePreviewView(selectedRecipe: $selectedRecipe)
                
                NavigationLink {
                    RecipeDetailPageView(selectedRecipe: $selectedRecipe)
                } label: {
                    HStack {
                        Image(systemName: "doc.richtext")
                            .frame(width: 30, height: 30)
                        Text("레시피 모아보기")
                        Spacer()
                    }
                    .font(.title3)
                }

                /* 레시피 줄글
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
                        .frame(width: 30, height: 30)
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
        .onAppear{
            print(selectedRecipe.RCP_PARTS_DTLS)
        }
    }
}



//struct RecipeDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDetail(selectedRecipe: EachRecipeDetail(), isRecipeMediaOn: false)
//    }
//}
