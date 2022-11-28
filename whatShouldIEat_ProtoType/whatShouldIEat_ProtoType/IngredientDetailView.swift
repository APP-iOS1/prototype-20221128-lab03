//
//  IngredientDetailView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/08.
//

import SwiftUI

struct IngredientDetailView: View {
    @State var expDate = Date()
    @State var isDateOn : Bool = false

    @Binding var isShowing : Bool
    @Binding var ingredient : Ingredient
    
    //데이터 포멧 설정
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    
    var body: some View {
        VStack {
            VStack(alignment : .leading, spacing: 20) {
                HStack {
                    Image(ingredient.icon)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
                    
                    VStack(alignment : .leading) {
                        Text(ingredient.ingredient)
                            .font(.title3)
                            .fontWeight(.bold)
                        HStack {
                            Text(ingredient.category)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 5)
                                .background(Color("lightOrange"))
                                .fontWeight(.bold)
                                .font(.system(size: 12))
                                .foregroundColor(.blue)
                                .cornerRadius(20)
                            if ingredient.isFrozen {
                                Text("냉동")
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 5)
                                    .background(Color("lightBlue"))
                                    .fontWeight(.black)
                                    .font(.system(size: 12))
                                    .foregroundColor(.blue)
                                    .cornerRadius(20)
                            }
                           
                        }
                        
                    } // 이름 Vstack
                    
                } // 상단 Hstack
                .padding(.top, 20)
                
                Group {
                    HStack {
                        Image(systemName: "calendar")
                        Text("추가된 날짜")
                        
                        Spacer()
                            .frame(width: 87)
                        
                        Text(Date.now, style: .date)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color(UIColor.systemGray6))
                            .font(.system(size: 15))
                            .foregroundColor(Color("fixdataColor"))
                            .cornerRadius(5)
                    } // 추가된 날짜
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text("유통기한")
                        
                        Spacer()
                            .frame(width: 101)
                        
                        Text("\(expDate, formatter: dateFormatter)")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .frame(width : 155)
                            .background(.yellow)
                            .font(.system(size: 15))
                            .foregroundColor(.black)
                            .cornerRadius(5)
                            .opacity(ingredient.isFrozen ? 0.1 : 1)
                            .onTapGesture {
                                if !ingredient.isFrozen {
                                    isDateOn = true
                                }
                            }
                            .sheet(isPresented: $isDateOn) {
                                DatePickerView(expDate: $expDate)
                                    .presentationDetents([.medium])
                            }

                    } // 소비기한 마감
                    
                    HStack {
                        Toggle(isOn: $ingredient.isFrozen) {
                            HStack {
                                Image(systemName: "snowflake")
                                Text("냉동실 보관")
                            }
                        }
                        .padding(.trailing, 30)
                    } // 추가된 날짜
                }
                .padding(.leading, 20)
                
            }// main Vstack
            
            Spacer()
            
            Button {
                ingredient.ishave = false
                isShowing = false
            } label: {
                HStack {
                    Image(systemName: "trash")
                    Text("삭제하기")
                }
            }
            .padding(.bottom, 50)
            
            
        }
    }
}

struct DatePickerView : View {
    
    @Binding var expDate : Date
    
    var body: some View {
        DatePicker("날짜를 선택하세요", selection: $expDate, in: Date()..., displayedComponents: .date)
            .datePickerStyle(.wheel)
            .labelsHidden()
            .environment(\.locale, Locale.init(identifier: "ko"))
    }
}

//struct IngredientDetailView_Previews: PreviewProvider {
//    @State private var isShowing: Bool = true
//    static var previews: some View {
//        IngredientDetailView()
//    }
//}
