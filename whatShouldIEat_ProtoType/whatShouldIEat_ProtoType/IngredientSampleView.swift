//
//  IngredientSampleView.swift
//  whatShouldIEat_ProtoType
//
//  Created by Da Hae Lee on 2022/11/29.
//

import SwiftUI

struct IngredientSampleView: View {
    @ObservedObject var ingredients: IngredientStore = IngredientStore()
    @State var isDone: Bool = false
    let ingredientFetcher: IngredientFetcher = IngredientFetcher()
    @State var ssub: Set<String> = Set<String>()
    
    var body: some View {
        VStack {
            if !isDone {
                ProgressView()
            } else {
                let temp = ingredients.ingredientSamples.cookrcp01.row.map {
                    $0["RCP_PARTS_DTLS"]!
                }
                ScrollView {
                    
                    ForEach(temp, id:\.self ) { item in
                        ForEach(item.split(separator: ","), id:\.self) { sub in
                            let subsub = String(sub)
                            let subsubsub = subsub.contains("(") ? String(subsub.split(separator: "(").first!)
                            : subsub.contains(" ") ? String(subsub.split(separator: " ").first!) : subsub
                            Text("\(subsubsub)")
                            
                        }
                        Divider()
                    }
                }
            }
        }
        .onAppear {
            
            Task {
                // fetchData 호출
                ingredients.ingredientSamples = try await ingredientFetcher.fecthData()
                isDone = true
                ingredients.doSomething()
            }
        }
    }
        
}

//struct IngredientSampleView_Previews: PreviewProvider {
//    static var previews: some View {
//        IngredientSampleView()
//    }
//}
