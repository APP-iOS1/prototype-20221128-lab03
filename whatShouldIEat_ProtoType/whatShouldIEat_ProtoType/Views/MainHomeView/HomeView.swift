import SwiftUI

struct HomeView: View {
    @EnvironmentObject var ingredientStore: IngredientStore
    @State private var isAvailableView: Bool = false
    @State private var isAddViewShow: Bool = false
    @State private var selectedIndex: Int = 0
    let pickerLabelList: [String] = ["냉장실", "냉동실", "실온 보관"]
    
    let columns = [
        //추가 하면 할수록 화면에 보여지는 개수가 변함
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        //        let ingredientCount = ingredientStore.ingredients.filter { $0.ishave }.count
        let isMyIngredientEmpty = ingredientStore.ingredientsDictionary.isEmpty
        //		let isMyFrozonIngredientEmpty = ingredientStore.ingredientsDictionary.values.filter { $0. }
        
        VStack {
            VStack(alignment: .leading) { // isHave ==  true인 재료가 보여짐
                /// selection: Int (현재 임시로 1로 박아둠)
                Picker("Choose a side", selection: $selectedIndex) {
                    ForEach(0..<3, id:\.self) { index in
                        Text("\(pickerLabelList[index])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                TabView(selection: $selectedIndex) {
                    // Group은 Container이므로, View와 같지 않다. 그래서 TabItem을 Group에 설정하면 원하는대로 안될 수 있다.
                    // tab1. 냉장실
                    VStack {
//                        Text("냉장실")
//                            .font(.title)
//                            .fontWeight(.semibold)
//                            .frame(width: 350, height: 50, alignment: .leading)
                        
                        // 냉장실 재료가 있을 때, 없을 때 구분
                        if isMyIngredientEmpty {
                            VStack { // 냉장실에 재료가 없을 때
                                Spacer()
                                Text("냉장실이 텅 비어 있어요😭")
                                Spacer()
                            }
                        } else {
                            ScrollView {
                                LazyVGrid(columns: columns) {
                                    ForEach(ingredientData, id: \.self) { eachIngredient in
                                        let key = eachIngredient.ingredient
                                        if let myIngredient = ingredientStore.ingredientsDictionary[key] {
                                            ForEach(myIngredient, id: \.self) { str in
                                                Text(str.ingredient)
                                            }
                                        }
                                    }
                                }
                            }
                            Text("냉장고 털러가기")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 150, height: 40)
                                .background(Color.blue)
                                .cornerRadius(20)
                                .onTapGesture { isAvailableView = true }
                        }
                    }
                    .tabItem {
                        Text("냉장실")
                    }
                    .tag(0)
                    
                    // tab2. 냉동실
                    VStack {
//                        Text("냉동실")
//                            .font(.title)
//                            .fontWeight(.semibold)
//                            .frame(width: 350, height: 50, alignment: .leading)
                        
                        let frozenIngredientCount = ingredientStore.ingredients.filter { $0.isFrozen }.count
                        
                        if frozenIngredientCount == 0 {
                            VStack { // 냉장실에 재료가 없을 때
                                Spacer()
                                Text("냉동실이 텅 비어 있어요😭")
                                Spacer()
                            }
                        } else {
                            ScrollView {
                                LazyVGrid(columns: columns) {
                                    ForEach($ingredientStore.ingredients) { ingredient in
                                        if ingredient.wrappedValue.ishave && ingredient.wrappedValue.isFrozen {
                                            IngredientCell(ingredient: ingredient)
                                        }
                                    }
                                }
                                Text("냉장고 털러가기")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 150, height: 40)
                                    .background(Color.blue)
                                    .cornerRadius(20)
                                    .onTapGesture { isAvailableView = true }
                            }
                        }
                    }
                    .tabItem {
                        Text("냉동실")
                    }
                    .tag(1)
                    
                    // tab3. 실온보관
                    VStack {
//                        Text("실온 보관")
//                            .font(.title)
//                            .fontWeight(.semibold)
//                            .frame(width: 350, height: 50, alignment: .leading)
                        
                        // FIXME: 실온 보관 카테고리 미완성 (실온 보관 재료들에 대한 데이터 없음)
                        // 구조만 만들어둠, 추후에 true 자리 변경하시오.
                        if true {
                            VStack {
                                Spacer()
                                Text("실온 보관할 것이 없어요😭")
                                Spacer()
                            }
                        } else {
                            ScrollView {
                                LazyVGrid(columns: columns) {
                                    ForEach($ingredientStore.ingredients) { ingredient in
                                        if ingredient.wrappedValue.ishave && ingredient.wrappedValue.isFrozen {
                                            IngredientCell(ingredient: ingredient)
                                        }
                                    }
                                }
                                Text("냉장고 털러가기")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 150, height: 40)
                                    .background(Color.blue)
                                    .cornerRadius(20)
                                    .onTapGesture { isAvailableView = true }
                            }
                        }
                    }
                    .tabItem {
                        Text("실온 보관")
                    }
                    .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                    
            }
    
            Spacer()
        }
        // main Vstack
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("나의 냉장고")
                    .font(.largeTitle)
                    .accessibilityAddTraits(.isHeader)
            }
        }
        .navigationBarItems(trailing: NavigationLink {
            AddIngredientView(ingredientStore: ingredientStore)
        } label: {
            Image(systemName: "plus").foregroundColor(.blue)
        })
    }
}// body

//}

struct IngredientCell: View {
    @Binding var ingredient: Ingredient
    @State private var isShowing: Bool = false
    
    var body: some View {
        
        Button {
            isShowing.toggle()
        } label: {
            VStack(spacing: 10) {
                Image(ingredient.icon)
                    .resizable()
                    .frame(width: 30, height: 30)
                Text(ingredient.ingredient)
                    .foregroundColor(.black)
                //                    .fontWeight(.semibold)
            }
        }
        .sheet(isPresented: $isShowing) {
            IngredientDetailView(
                isShowing: $isShowing,
                ingredient: $ingredient
            )
            .presentationDetents([.medium, .large])
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
