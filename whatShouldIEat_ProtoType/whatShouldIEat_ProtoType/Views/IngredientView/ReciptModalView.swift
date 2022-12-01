//
//  ReciptModalView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 진태영 on 2022/12/01.
//

import SwiftUI

struct ReciptModalView: View {
    @State var newReciptIngredient: [String] = ["", "", ""]
    @State var selectedImage: Image? = nil
    @State var imagePickerVisible: Bool = false
    
    @Binding var newIngredientArr: [NewIngredient]
    @Binding var isReciptModalPresented: Bool
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    Spacer()
                    if selectedImage != nil {
                        Image("recipt2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250)
                    }
                    
                    Button {
                        //                    if selectedImage != nil{
                        //                        isImage.toggle()
                        //                    }
                    } label: {
                        Image(systemName: "camera")
                        Text("영수증 촬영하기")
                    }
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 300, height: 45)
                    .background(Color(red: 0.997, green: 0.681, blue: 0.0))
                    .cornerRadius(30)
                    .padding()
                    
                    Button {
                        self.imagePickerVisible.toggle()
                        //                    if selectedImage != nil{
                        //                        isImage.toggle()
                        //                    }
                    } label: {
                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                            Text("사진으로 첨부하기")
                        }
                        .foregroundColor(.black)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(.black, lineWidth: 1.8)
                                .frame(width: 300, height: 45)
                        )
                    }
                    Spacer()
                    if selectedImage != nil{
                        VStack{
                            HStack{
                                TextField("우유", text: $newReciptIngredient[0])
                                Spacer()
                            }
                            .padding()
                            HStack{
                                TextField("돼지고기", text: $newReciptIngredient[1])
                                    Spacer()
                                    
                    
                            }
                            .padding()
                            HStack{
                                TextField("플레인요거트", text: $newReciptIngredient[2])
                                Spacer()
                            }
                            .padding()
                        }
                        .padding()
                        .font(.title2)
                            Button {
                                isReciptModalPresented.toggle()
                                newIngredientArr.append(NewIngredient(category: "육류/달걀", name: "돼지고기"))
                                newIngredientArr.append(NewIngredient(category: "유제품", name: "우유"))
                                newIngredientArr.append(NewIngredient(category: "유제품", name: "플레인요거트"))
                            } label: {
                                Text("추가하기")
                            }
                    }
                }
            }
            if imagePickerVisible{
                ImagePicker(imagePickerVisible: $imagePickerVisible, selectedImage: $selectedImage)
            }
        }
    }
}

//struct ReciptModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReciptModalView(newReciptIngredient: .constant(["", "", ""]), newIngredientArr: .constant(NewIngredient(category: "", name: "")), isReciptModalPresented: .constant(true))
//    }
//}
