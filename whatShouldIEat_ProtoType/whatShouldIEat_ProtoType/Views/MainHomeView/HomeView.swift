import SwiftUI

struct HomeView: View {
    @EnvironmentObject var ingredientStore: IngredientStore
    @State private var isAvailableView: Bool = false
    @State private var isAddViewShow: Bool = false
    @State private var selectedIndex: Int = 0
    @Binding var isAvailableRecipes : Bool
    @Binding var tagSelection : Int
    let pickerLabelList: [String] = ["냉장실", "냉동실", "실온 보관"]
    
    let columns = [
        //추가 하면 할수록 화면에 보여지는 개수가 변함
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        // 재료 배열을 돌면서 냉장, 냉동, 실온 상태의 재료들의 갯수를 체크하여 비어있는지 여부를 반환
        let isMyRefrigerationIngredientEmpty = ingredientStore.ingredientsDictionary.map{ingredients in
            ingredients.value.filter{$0.saveWhere == .refrigeration}.count
        }.reduce(0,+) == 0
        let isMyFrozenIngredientEmpty = ingredientStore.ingredientsDictionary.map{ingredients in
            ingredients.value.filter{$0.saveWhere == .frozen}.count
        }.reduce(0,+) == 0
        let isMyRoomTemperatureIngredientEmpty = ingredientStore.ingredientsDictionary.map{ingredients in
            ingredients.value.filter{$0.saveWhere == .roomTemperature}.count
        }.reduce(0,+) == 0
        
        VStack {
            VStack(alignment: .leading) { // isHave ==  true인 재료가 보여짐
                Picker("Choose a side", selection: $selectedIndex) {
                    ForEach(0..<3, id:\.self) { index in
                        Text("\(pickerLabelList[index])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                TabView(selection: $selectedIndex) {
                    /// Group은 Container이므로, View와 같지 않다.
                    /// 그래서 TabItem을 Group에 설정하면 원하는대로 안될 수 있다.
                    // tab1. 냉장실
                    VStack {
                        // 냉장실 재료가 있을 때, 없을 때 구분
                        if isMyRefrigerationIngredientEmpty {
                            VStack { // 냉장실에 재료가 없을 때
                                Spacer()
                                Text("냉장실이 텅 비어 있어요😭")
                                Spacer()
                            }
                        } else {
                            ScrollView {
                                LazyVGrid(columns: columns) {
                                    ForEach(Array(ingredientStore.ingredientsDictionary.keys), id: \.self) { eachIngredient in
                                        if let myIngredient = ingredientStore.ingredientsDictionary[eachIngredient] {
                                            ForEach(myIngredient, id: \.self) { str in
                                                if str.saveWhere == .refrigeration {
                                                    IngredientCell(ingredient: str)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            goToAvailableRecipeView
                        }
                    }
                    .tabItem {
                        Text("냉장실")
                    }
                    .tag(0)
                    
                    // tab2. 냉동실
                    VStack {
                        if isMyFrozenIngredientEmpty {
                            VStack { // 냉장실에 재료가 없을 때
                                Spacer()
                                Text("냉동실이 텅 비어 있어요😭")
                                Spacer()
                            }
                        } else {
                            ScrollView {
                                LazyVGrid(columns: columns) {
                                    ForEach(Array(ingredientStore.ingredientsDictionary.keys), id: \.self) { eachIngredient in
                                        if let myIngredient = ingredientStore.ingredientsDictionary[eachIngredient] {
                                            ForEach(myIngredient, id: \.self) { str in
                                                if str.saveWhere == .frozen {
                                                    IngredientCell(ingredient: str)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            goToAvailableRecipeView
                        }
                    }
                    .tabItem {
                        Text("냉동실")
                    }
                    .tag(1)
                    
                    // tab3. 실온보관
                    VStack {
                        if isMyRoomTemperatureIngredientEmpty {
                            VStack {
                                Spacer()
                                Text("실온 보관할 것이 없어요😭")
                                Spacer()
                            }
                        } else {
                            ScrollView {
                                LazyVGrid(columns: columns) {
                                    ForEach(Array(ingredientStore.ingredientsDictionary.keys), id: \.self) { eachIngredient in
                                        if let myIngredient = ingredientStore.ingredientsDictionary[eachIngredient] {
                                            ForEach(myIngredient, id: \.self) { str in
                                                if str.saveWhere == .roomTemperature {
                                                    IngredientCell(ingredient: str)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            goToAvailableRecipeView
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
    private var goToAvailableRecipeView : some View {
        Text("냉장고 털러가기")
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 150, height: 40)
            .background(Color.blue)
            .cornerRadius(20)
            .onTapGesture {
                isAvailableRecipes = true
                tagSelection = 1
            }
    }
}


struct IngredientCell: View {
    @State var ingredient: Ingredient
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
                Text("\(ingredient.addCounter!) \(ingredient.ingredientUnit!.rawValue)")
                    .font(.subheadline)
            }
        }
        .sheet(isPresented: $isShowing) {
            IngredientDetailView(
                expDate: ingredient.expiredDate ?? Date(),
                isShowing: $isShowing,
                ingredient: $ingredient
            )
            .presentationDetents([.medium, .large])
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
