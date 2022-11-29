//
//  GridTestView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/10.
// MARK: 테스트용 파일
//
//import SwiftUI
//
//struct GridTestView: View {
//    let columns = [
//      //추가 하면 할수록 화면에 보여지는 개수가 변함
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
//
//    @ObservedObject var ingredientStore : IngredientStore = IngredientStore(ingredients: ingredientData)
//
//    var body: some View {
//
//        ScrollView {
//            LazyVGrid(columns: columns) {
//                ForEach(ingredientStore.ingredients) { item in
//                    VStack {
//                        Image(item.icon)
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                        Text(item.ingredient)
//                    }
//
//                }
//            }
//        }
//
//
//    }
//}
//
//struct GridTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        GridTestView()
//    }
//}
