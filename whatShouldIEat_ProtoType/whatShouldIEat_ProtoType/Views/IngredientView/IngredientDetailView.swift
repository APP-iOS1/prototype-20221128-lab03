//
//  IngredientDetailView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 원태영 on 2022/11/08.
//

import SwiftUI

struct IngredientDetailView: View {
    @EnvironmentObject var ingredientStore : IngredientStore
    @State var expDate = Date()
    @State var isDateOn : Bool = false
    @Binding var isShowing : Bool
    @Binding var ingredient : Ingredient
    
    //데이터 포멧 설정
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
    }
    
    var body: some View {
        
        let saveWhereList = IngredientStore().ingredientSaveWhereList
        
        VStack {
            VStack(alignment : .leading, spacing: 20) {
                HStack {
                    Image(ingredient.icon)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
                    
                    VStack(alignment: .leading) {
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
                            
                            Text(ingredient.saveWhere.rawValue)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 5)
                                .background(Color("lightBlue"))
                                .fontWeight(.black)
                                .font(.system(size: 12))
                                .foregroundColor(.blue)
                                .cornerRadius(20)
                            
                           
                        }
                        
                    } // 이름 Vstack
                    
                } // 상단 Hstack
                .padding(.top, 20)
                
                Group {
                    // 추가된 날짜
                    HStack {
                        Image(systemName: "calendar")
                        Text("추가된 날짜")
                        
                        Spacer()
                        
//                        Text(Date.now, style: .date)
                        Text("\(Date.now, formatter: dateFormatter)")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color(UIColor.systemGray6))
                            .font(.system(size: 15))
                            .foregroundColor(Color("fixdataColor"))
                            .cornerRadius(5)
                    }
					.padding(.trailing, 20)
                    
                    // 유통기한
                    HStack {
                        Image(systemName: "calendar")
                        Text("유통기한")
                        
                        Spacer()
                        
                        Text("\(expDate, formatter: dateFormatter)")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
//                            .frame(width : 155)
                            .background(.yellow)
                            .font(.system(size: 15))
                            .foregroundColor(.black)
                            .cornerRadius(5)
                            .opacity(ingredient.saveWhere == .frozen ? 0.1 : 1)
                            .onTapGesture {
                                if ingredient.saveWhere != .frozen {
                                    isDateOn = true
                                }
                            }
                            .sheet(isPresented: $isDateOn) {
                                DatePickerView(expDate: $expDate)
                                    .presentationDetents([.medium])
                                    
                            }
                    }
					.padding(.trailing, 20)
                    
                    // 소비기한
                    HStack {
                        Image(systemName: "calendar.badge.exclamationmark")
//                        Image(systemName: "calendar.badge.plus")
                        Text("소비기한")
                        
                        Spacer()

                        Text("\(Calendar.current.date(byAdding: .day, value:7, to: expDate)!, formatter: dateFormatter)까지")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
//                            .background(Color(UIColor.systemGray6))
                            .font(.system(size: 15))
                            .foregroundColor(Color.accentColor)
                            .bold()
//                            .cornerRadius(5)
                    }
                    
                    HStack {
                        Label("보관 방법", systemImage: "snowflake")
                        
                        Spacer()
                        
                        Picker("", selection: $ingredient.saveWhere) {
                            ForEach(saveWhereList, id: \.self ) { saveWhere in
                                Text(saveWhere.rawValue)
                            }
                        }
                        .padding(.trailing, 30)
                    } // 추가된 날짜
                }
                .padding(.leading, 20)
                
            }// main Vstack
            
            Spacer()
            
            Button {
                // 감자 배열에서 이 감자와 같은 id를 찾아서 삭제하는 로직
                ingredientStore
                    .ingredientsDictionary[ingredient.ingredient]!
                    .remove(at : ingredientStore.getIngredientIndex(ingredient: ingredient))
                isShowing = false
            } label: {
                HStack {
                    Image(systemName: "trash")
                    Text("삭제하기")
                }
            }
            .padding(.bottom, 50)
        }
        .onDisappear{
            // 보관 방법이 변경되었을때, ingredientDictionary에 반영
            // 해당 재료를 삭제하면 Index 문제가 일어나기 때문에, 재료가 ingredientDictionary에 존재하는지 체크 후 반영함
            if !ingredientStore.ingredientsDictionary[ingredient.ingredient]!.enumerated().filter{$0.element.id == ingredient.id}.isEmpty {
                ingredientStore.ingredientsDictionary[ingredient.ingredient]![ingredientStore.getIngredientIndex(ingredient: ingredient)].saveWhere = ingredient.saveWhere
            }
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
