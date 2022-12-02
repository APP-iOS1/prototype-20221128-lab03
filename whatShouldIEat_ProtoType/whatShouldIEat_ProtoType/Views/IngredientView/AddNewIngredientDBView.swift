//
//  AddNewIngredientDBView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/12/02.
//

import SwiftUI

struct AddNewIngredientDBView: View {
    
    let category : String
    @EnvironmentObject var ingredientStore : IngredientStore
    @State var ingredientName : String = ""
    @Binding var isAddNewIngredientModalPresented : Bool
    
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("카테고리 :")
                Spacer()
                Text(category)
            }
            .padding(.bottom,50)
            
            
            HStack {
                Text("재료 이름 : ")
                Spacer()
                TextField("이름을 입력해주세요", text: $ingredientName)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.bottom,50)
            
            Button {
                foodDb[category]?.append(ingredientName)
                isAddNewIngredientModalPresented = false
            } label: {
                Text("추가하기")
                    .foregroundColor(Color.accentColor)
            }
            Spacer()
        }
        .font(.title3)
        .padding(.horizontal, 30)
    }
}

//struct AddNewIngredientDBView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewIngredientDBView(category: "채소/과일", ingredientName: "망고")
//    }
//}
